import 'dart:async';

import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/repositories/user_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;

class ExpenseDetailController extends ControllerMVC{
  bool call = true;
  List<String> monthsLocal = ['None', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  List<String> yearLocal = [];
  Timer timer = Timer.periodic(Duration(seconds: 10), (timer) { });
  Timer timer2 = Timer.periodic(Duration(seconds: 10), (timer) { });
  int total = 0;

  Map<String, List<ExpenseModel>> expenseList = Map<String, List<ExpenseModel>>();

  ExpenseDetailController(){
    monthsLocal = monthsLocal.sublist(1, exRepo.latest_month+1);
    for(var i = exRepo.oldest_year; i<=exRepo.latest_year; i++){
      yearLocal.add(i.toString());
    }
  }

  Future<void> getExpensesMonth(context, month, year) async{
    var qp = {
      'year': year,
      'month': month,
      'user_id': userRepo.currentUser.id
    };

    if(call) {
      await exRepo.getExpensesDynamicQP(context, qp: qp);
      calculateTotal();
      prepareList();
    }
  }

  Future<void> calculateTotal() async{
    total = 0;
    for(var exp in exRepo.expenses){
      total = total + int.parse(exp.amount);
    }
  }

  Future<void> prepareList() async{
    expenseList.clear();
    for(var exp in exRepo.expenses){
      String tempDate = exp.expense_date.substring(8, 10);
      if(!expenseList.containsKey(tempDate)){
        expenseList[tempDate] = [];
      }
      expenseList[tempDate].add(exp);
    }
    setState(() {});
  }

}