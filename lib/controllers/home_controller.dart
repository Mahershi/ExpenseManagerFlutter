import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/models/DataSet.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;

class HomeController extends ControllerMVC{
  int currentMonth = DateTime.now().month;
  int currentYear = exRepo.latest_year;
  int maxValue = 0;
  List<BarChartGroupData> rawData = List<BarChartGroupData>();
  Map<int, dynamic> dataBarGraph = {};

  DateTime today = DateTime.now();


  Map<String, List<ExpenseModel>> expenseList = Map<String, List<ExpenseModel>>();

  HomeController();

  Future<void> getClusters() async{
    await clusterRepo.getClusters(this.stateMVC.context);
  }

  Future<void> getExpenses6Months(context) async{
    DateTime today = DateTime.now();
    String todayString = today.year.toString() + "-" + today.month.toString() + '-' + '30';
    today = DateTime(today.year, today.month-6, 1);
    String spanString = today.year.toString() + "-" + (today.month).toString() + '-' + today.day.toString();

    var qp = {
      'start': spanString,
      'end': todayString,
      'user_id': userRepo.currentUser.id
    };

    await exRepo.getExpensesDynamicQP(context, qp: qp);
    await prepareList();
    makeDataSets(context);
  }


  void makeDataSets(context){
    int prevMonth = 1;
    dataBarGraph.clear();
    rawData = [];
    for(var ex in exRepo.expenses){
      dataBarGraph[ex.month] = {
        'amount': 0,
        'year': ex.year
      };
    }
    for(var ex in exRepo.expenses){
      dataBarGraph[ex.month]['amount'] = dataBarGraph[ex.month]['amount'] + int.parse(ex.amount);
    }
  dataBarGraph.forEach((key, value) {
    if(value['amount'] > maxValue)
      maxValue = value['amount'];
  });

    if(dataBarGraph.isNotEmpty){
      for(var i=dataBarGraph.keys.first, j=0; j<6; j++){
        rawData.insert(0, DataModel(
            x: i,
            y: dataBarGraph.containsKey(i) ? dataBarGraph[i]['amount'].toDouble() : 0.0
        ).getBarChartGroupData(MediaQuery.of(context).size.width/9, currentMonth, true)
        );
        if(i==1){
          i=12;
        }else{
          i--;
        }
      }

    }else{
      int j=currentMonth;
      for(var i=0; i<6; i++){
        rawData.insert(0, DataModel(
            x:  j,
            y:  0.0
        ).getBarChartGroupData(MediaQuery.of(context).size.width/9, currentMonth, false)
        );
        if(j == 1){
          j = 12;
        }else{
          j--;
        }
      }
    }
    if(this.stateMVC.mounted) {
      setState(() {});
    }
  }


  Future<void> getExpensesTimeSpane(context) async{
    var qp = {
      'user_id': userRepo.currentUser.id
    };
    await exRepo.getSpan(context, qp:qp);
    currentYear = exRepo.latest_year;
  }

  Future<void> prepareList({days = 7}) async {
    expenseList.clear();
    for(var i in exRepo.expenses){
      DateTime temp = DateTime.parse(i.expense_date);
      if(today.difference(temp) < Duration(days: days))
      {
        if (!expenseList.containsKey(temp.toString().substring(0, 10)))
          expenseList[temp.toString().substring(0, 10)] = [];
        expenseList[temp.toString().substring(0, 10)].add(i);
      }
    }
  }
}