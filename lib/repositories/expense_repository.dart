import 'dart:developer';

import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/models/cluster_model.dart';

import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:expensemanager/network/APIs.dart';
import 'package:expensemanager/network/rest_service.dart';

List<ClusterModel> clusters = List<ClusterModel>();
List<ExpenseModel> expenses = List<ExpenseModel>();

int latest_month = 0;
int latest_year = 0;
int oldest_month = 0;
int oldest_year = 0;

Future<void> getExpensesDynamicQP(context, {qp = const {}}) async{
  var resp = await RestService.request(
    context: context,
    endpoint: API.expenses,
    authRequired: false,
    queryParameters: qp
  );
  print("SSS");
  log(resp['data'].toString());
  if(resp['success'] == 'true'){
    expenses.clear();
    for (var i in resp['data']){
      var expense = ExpenseModel.fromJson(i);
      expenses.add(expense);
    }
  }
}

Future<void> getSpan(context, {qp = const {}}) async{
  var resp = await RestService.request(
      context: context,
      endpoint: API.expenses_span,
      authRequired: false,
      queryParameters: qp
  );
  if(resp['success'] == 'true'){
    latest_month = int.parse(resp['data']['latest_month'].toString());
    latest_year = int.parse(resp['data']['latest_year'].toString());
    oldest_month = int.parse(resp['data']['oldest_month'].toString());
    oldest_year = int.parse(resp['data']['oldest_year'].toString());
  }else{
    latest_month = DateTime.now().month;
    latest_year = DateTime.now().year;
    oldest_month = int.parse(resp['data']['oldest_month'].toString());
    oldest_year = int.parse(resp['data']['oldest_year'].toString());
  }
}
