import 'package:expensemanager/helpers/custom_trace.dart';
import 'package:expensemanager/network/APIs.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:expensemanager/repositories/user_repo.dart';

class ExpenseModel{
  String id;
  String name;
  String amount;
  String user_id;
  String cluster_id;
  String category_id;
  String expense_date;

  int month;
  int year;

  //for creating without datetime timezone
  ExpenseModel.createNew(){
    user_id = userRepo.currentUser.id;
    expense_date = DateTime.now().toIso8601String();
    category_id = "1";
    cluster_id = '0';
    amount = "";
    name = '';
    id = null;
  }

  ExpenseModel.createFor(monthLocal, yearLocal){
    id = null;
    cluster_id = '0';
    category_id = '1';
    name = '';
    amount = '';
    DateTime time = DateTime.now();
    expense_date = DateTime(yearLocal, monthLocal, DateTime.now().day, time.hour, time.minute, time.second).toString();
    user_id = currentUser.id;
  }

  ExpenseModel.createForCluster(clusterId){
    id = null;
    cluster_id = clusterId;
    category_id = '1';
    name = '';
    amount = '';
    expense_date = DateTime.now().toIso8601String();
    user_id = currentUser.id;
  }

  ExpenseModel();

  ExpenseModel.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
      name = jsonMap['name'] ?? null;
      amount = jsonMap['amount'] != null ? jsonMap['amount'].toString() : '0';
      user_id = jsonMap['user_id'] != null ? jsonMap['user_id'].toString() : null;
      cluster_id = jsonMap['cluster'] != null ? jsonMap['cluster'].toString() : null;
      category_id = jsonMap['category'] != null ? jsonMap['category'].toString() : null;
      expense_date = jsonMap['expense_date'] != null ? jsonMap['expense_date'].toString() : null;

      month = int.parse(expense_date.substring(5, 7));
      year = int.parse(expense_date.substring(0, 4));
    }catch(e){
      print(e.toString());
      CustomTrace(StackTrace.current, message: e.toString());
    }
  }


  //when modifying existing expense, server will ignore "cluster" key.
  //cluster can only be changed by its specific API
  Map toMap(){
    var m = Map<String, dynamic>();
    m['id'] = id != null ? int.parse(id) : null;
    m['name'] = name;
    m['user_id'] = int.parse(user_id);
    m['cluster'] = cluster_id;
    m['category'] = int.parse(category_id);
    m['amount'] = int.parse(amount);
    m['expense_date'] = expense_date;

    return m;
  }


}