import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/elements/cluster_edit.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;
import 'package:expensemanager/repositories/user_repo.dart';

class ClusterController extends ControllerMVC{
  ClusterModel newCluster;
  ClusterModel currentCluster;
  List<ExpenseModel> expenses = [];
  Map<String, List<ExpenseModel>> expenseList = Map<String, List<ExpenseModel>>();
  int total = 0;

  Future<void> getExpensesForClusterId(context, clusterId) async{

    var qp = {
      'cluster': clusterId,
      'user_id': currentUser.id
    };
    var data = await exRepo.getExpensesDynamicQP(context, qp: qp, returnOrNot: true);
    expenses.clear();
    for (var ex in data){
      ExpenseModel e = ExpenseModel.fromJson(ex);
      expenses.add(e);
    }
    calculateTotal();
    prepareList();
  }

  Future<void> fetchClusters(context) async{
    print("fetching");
    await clusterRepo.getClusters(context);
    setState(() { });
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

  Future<void> prepareList() async {
    expenseList.clear();
    for(var i in expenses){
      DateTime temp = DateTime.parse(i.expense_date);
      if (!expenseList.containsKey(temp.toString().substring(0, 10)))
        expenseList[temp.toString().substring(0, 10)] = [];
      expenseList[temp.toString().substring(0, 10)].add(i);
    }
    setState(() { });
  }

  Future<void> calculateTotal() async{
    total = 0;
    for (var ex in expenses){
      total += int.parse(ex.amount);
    }
  }
}