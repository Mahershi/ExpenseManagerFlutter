import 'package:expensemanager/repositories/user_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;

class ExpenseDetailController extends ControllerMVC{
  List<String> monthsLocal = ['None', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  List<String> yearLocal = [];

  ExpenseDetailController(){
    print(exRepo.latest_month+1);
    monthsLocal = monthsLocal.sublist(1, exRepo.latest_month+1);
    print(monthsLocal.toString());

    for(var i = exRepo.oldest_year; i<=exRepo.latest_year; i++){
      yearLocal.add(i.toString());
    }
  }


}