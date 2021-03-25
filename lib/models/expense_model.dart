import 'package:expensemanager/helpers/custom_trace.dart';
import 'package:expensemanager/network/APIs.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;

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

  ExpenseModel.createNew(){
    user_id = userRepo.currentUser.id;
    expense_date = DateTime.now().toIso8601String();
    category_id = "1";
    cluster_id = '0';
    amount = "0";
    name = '';
    id = null;
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

  Map toMap(){
    var m = Map<String, dynamic>();
    m['id'] = id != null ? int.parse(id) : null;
    m['name'] = name;
    m['user_id'] = int.parse(user_id);
    // m['cluster'] = cluster_id;
    m['category'] = int.parse(category_id);
    m['amount'] = int.parse(amount);
    m['expense_date'] = expense_date;

    return m;
  }
}