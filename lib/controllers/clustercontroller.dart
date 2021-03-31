import 'dart:collection';

import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/elements/cluster_edit.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;
import 'package:expensemanager/repositories/user_repo.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class ClusterController extends ControllerMVC{
  bool loaded = false;
  ClusterModel newCluster;
  ClusterModel currentCluster;
  List<ExpenseModel> expenses = [];
  Map<String, List<ExpenseModel>> expenseList = Map<String, List<ExpenseModel>>();
  int total = 0;
  int touchedIndex = -1;

  Map<String, List<ExpenseModel>> pieData = Map<String, List<ExpenseModel>>();

  List<PieChartSectionData> pieSections = List<PieChartSectionData>();
  Map<String, double> percentage = Map<String, double>();

  Future<void> getExpensesForClusterId(context, clusterId) async{
    expenses.clear();
    print("EX LENGHT  2222: " + expenses.length.toString());
    loaded = false;
    var qp = {
      'cluster': clusterId,
      'user_id': currentUser.id
    };
    var data = await exRepo.getExpensesDynamicQP(context, qp: qp, returnOrNot: true,);

    print("got expenses");
    for (var ex in data){
      ExpenseModel e = ExpenseModel.fromJson(ex);
      expenses.add(e);
      print("Added" + e.toMap().toString());
    }
    print("al added");
    await calculateTotal();
    await prepareListPie();
    await prepareList();
  }





  Future<void> prepareList() async {
    expenseList.clear();
    for(var i in expenses){
      DateTime temp = DateTime.parse(i.expense_date);
      if (!expenseList.containsKey(temp.toString().substring(0, 10)))
        expenseList[temp.toString().substring(0, 10)] = [];
      expenseList[temp.toString().substring(0, 10)].add(i);
    }
    setState(() {
      print("Settings Srtate: ");
      loaded = true;
    });
  }

  Future<void> prepareListPie() async{
    print("preparing Pi data");
    pieData.clear();
    for(var i in expenses){
      String cat = await settingsRepo.getCategoryById(i.category_id).name;
      if(!pieData.containsKey(cat)){
        pieData[cat] = [];
      }
      pieData[cat].add(i);
    }
    print("pie data dione");
    await calculatePercentage();
  }

  Future<void> calculatePercentage() async{

    int max = 0;
    percentage.clear();
    print("prepariung percent");
    for(var k in pieData.keys){
      int tempTotal = 0;
      for(var v in pieData[k]){
        print("V:");
        print(v.toMap().toString());
        tempTotal += int.parse(v.amount);
      }
      percentage[k] = (tempTotal / total)*100.0;
    }

    print("Percentages");
    for(var k in percentage.keys){
      print("CAt: " + k + ", " + percentage[k].toString());
    }
    // print("P Lengt: " + percentage.length.toString());
    // if(percentage.length > 1)
    //   pieData = sortMap();
  }

  dynamic sortMap() async{
    print("called sort map");
    SplayTreeMap<String, List<ExpenseModel>> sorted;
    print("PERCENTAGE: " + percentage.length.toString());
    sorted = SplayTreeMap.from(
      pieData, (k1, k2) => percentage[k2].compareTo(percentage[k1])
    );
    return sorted;
  }

  void reorder(id){
    print("called reorder");
    if(id == -1){
      // if(percentage.length > 1)
      //   pieData = sortMap();
    }
    else{
      // if(percentage.length > 1)
      //   pieData = sortMap();
      Map<String, List<ExpenseModel>> temp = {};
      for(var i=0; i<percentage.keys.length; i++){
        if(i==id){
          print("got it");
          String key = percentage.keys.elementAt(i);
          temp[key]=pieData[key];
          pieData.remove(key);
          break;
        }
      }
      print("Removed");
      for(var i in pieData.keys){
        print(i.toString());
      }
      temp.addAll(pieData);
      pieData = temp;
    }

  }

  List<PieChartSectionData> getSections(context){
    return List.generate(
      percentage.keys.length,
      (i){
        String percentageKey = percentage.keys.elementAt(i);
        bool isTouched = i == touchedIndex;
        print("Index: " + i.toString() + ", PC: " + percentage[percentageKey].toStringAsFixed(1));
        return PieChartSectionData(
          color: i < 9 ? colorsForPie[i] : colorsForPie[i-9],
          radius: isTouched ? MediaQuery.of(context).size.width * 0.13 : MediaQuery.of(context).size.width * 0.1,
          titleStyle: font.merge(
            TextStyle(
              fontSize: isTouched ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.025,
            )
          ),
          value: percentage[percentageKey],
          title: percentage[percentageKey].toStringAsFixed(1) + "%"
        );
      }
    );
  }

  List<Container> getLegend(){
    List<Container> legends = [];
    var j=0;
    for(var i in percentage.keys){
      legends.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: j < 9 ? colorsForPie[j] : colorsForPie[j-9],
                ),
                height: 12,
                width: 12,
              ),
              Text(
                i,
                style: font.merge(
                  TextStyle(

                  )
                ),
              )
            ],
          ),
        )
      );
      j++;
    }
    return legends;
  }

  Future<void> addNewCluster() async{
    newCluster = ClusterModel.create();
    showDialog(
        context: this.stateMVC.context,
        builder: (context){
          return ClusterEditDialog(cluster: newCluster,);
        }
    ).then((value) async {
      if(value != null){
        if(value != false){
          print(value.toMap().toString());
          await clusterRepo.addorModifyCluster(this.stateMVC.context, value).then((value) async{
            if(value){
              ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterList);
            }
          });
        }
      }
    });
  }

  Future<void> calculateTotal() async{
    total = 0;
    for (var ex in expenses){
      total += int.parse(ex.amount);
    }
  }

  Future<void> fetchClusters(context) async{
    print("fetching");
    await clusterRepo.getClusters(context);
    setState(() { });
  }
}