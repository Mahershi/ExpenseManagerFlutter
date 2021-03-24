import 'package:expensemanager/models/DataSet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;

class HomeController extends ControllerMVC{
  int currentMonth = DateTime.now().month;
  int maxValue = 10000;
  List<BarChartGroupData> rawData = List<BarChartGroupData>();
  Map<int, dynamic> dataBarGraph = {};

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
    await exRepo.getExpenses6Months(context, qp: qp);
    // currentMonth = exRepo.expenses.isNotEmpty ? exRepo.expenses.first.month : DateTime.now().month;

    makeDataSets(context);
  }

  Future<void> getExpensesMonth(context, month, year) async{

    var qp = {
      'year': year,
      'month': month,
      'user_id': userRepo.currentUser.id
    };
    await exRepo.getExpenses6Months(context, qp: qp);
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
        ).getBarChartGroupData(MediaQuery.of(context).size.width/9, currentMonth)
        );
        if(i==1){
          i=12;
        }else{
          i--;
        }
      }
      if(this.stateMVC.mounted) {
        setState(() {
          print("setting state");
        });
      }
    }
  }


  Future<void> getExpensesTimeSpane(context) async{
    var qp = {
      'user_id': userRepo.currentUser.id
    };
    await exRepo.getSpan(context, qp:qp);
  }
}