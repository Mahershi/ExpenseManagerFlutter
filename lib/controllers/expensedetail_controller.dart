import 'dart:async';

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

  ExpenseDetailController(){
    print(exRepo.latest_month+1);
    monthsLocal = monthsLocal.sublist(1, exRepo.latest_month+1);
    print(monthsLocal.toString());

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

    if(call)
      await exRepo.getExpensesDynamicQP(context, qp: qp);
  }


}