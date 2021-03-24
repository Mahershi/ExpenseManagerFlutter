import 'package:expensemanager/models/DataSet.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;

class HomeController extends ControllerMVC{
  int currentMonth = DateTime.now().month;
  int maxValue = 10000;
  List<BarChartGroupData> rawData = List<BarChartGroupData>();
  Map<int, dynamic> dataBarGraph = {};

  DateTime today = DateTime.now();


  Map<String, List<ExpenseModel>> expenses = Map<String, List<ExpenseModel>>();

  HomeController();


  Future<void> getExpenses6Months(context) async{
    DateTime today = DateTime.now();
    String todayString = today.year.toString() + "-" + today.month.toString() + '-' + '30';
    today = DateTime(today.year, today.month-6, 1);
    String spanString = today.year.toString() + "-" + (today.month).toString() + '-' + today.day.toString();
    print(todayString + "," + spanString);

    var qp = {
      'start': spanString,
      'end': todayString,
      'user_id': userRepo.currentUser.id
    };

    await exRepo.getExpensesDynamicQP(context, qp: qp);
    // currentMonth = exRepo.expenses.isNotEmpty ? exRepo.expenses.first.month : DateTime.now().month;
    prepareList();
    makeDataSets(context);
  }




  void makeDataSets(context){
    dataBarGraph.clear();
    rawData = [];
    for(var ex in exRepo.expenses){
      dataBarGraph[ex.month] = 0;
    }
    for(var ex in exRepo.expenses){
      dataBarGraph[ex.month] = dataBarGraph[ex.month] + int.parse(ex.amount);
    }
    print("Temp");
    print(dataBarGraph.toString());
  dataBarGraph.forEach((key, value) {
    if(value > maxValue)
      maxValue = value;
  });

    if(dataBarGraph.isNotEmpty){
      for(var i=dataBarGraph.keys.first, j=0; j<6; j++){
        rawData.insert(0, DataModel(
            x: i,
            y: dataBarGraph.containsKey(i) ? dataBarGraph[i].toDouble() : 0.0
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
      setState(() {
        print("setting state: " + exRepo.expenses.isEmpty.toString());
      });
    }
  }


  Future<void> getExpensesTimeSpane(context) async{
    var qp = {
      'user_id': userRepo.currentUser.id
    };
    await exRepo.getSpan(context, qp:qp);
  }

  Future<void> prepareList({days = 70}) async {
    for(var i in exRepo.expenses){
      DateTime temp = DateTime.parse(i.expense_date);
      print(temp.toString());
      print(today.difference(temp) < Duration(days: days));
      if(today.difference(temp) < Duration(days: days))
      {
        if (!expenses.containsKey(temp.toString().substring(0, 10)))
          expenses[temp.toString().substring(0, 10)] = [];
        expenses[temp.toString().substring(0, 10)].add(i);
        print("Added: " + i.toMap().toString());
        for (var j in expenses[temp.toString().substring(0, 10)])
          print(j.toMap().toString());
      }
    }
  }
}