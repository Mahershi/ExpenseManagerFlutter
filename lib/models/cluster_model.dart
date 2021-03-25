import 'package:expensemanager/helpers/custom_trace.dart';
import 'package:expensemanager/repositories/user_repo.dart';

class ClusterModel{
  String id;
  String name;
  String created_date;
  String expenses;
  String user_id;

  ClusterModel.create(){
    id = null;
    name = '';
    expenses = '0';
    user_id = currentUser.id;
    created_date = DateTime.now().toIso8601String();
  }

  ClusterModel.none(){
    id = '0';
    name = "None";
    expenses = '';
    created_date = '';
  }

  ClusterModel.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      name = jsonMap['name'] ?? '';
      expenses = jsonMap['expenses'] != null ? jsonMap['expenses'].toString() : "0";
      created_date = jsonMap['created_date'] ?? '';
      user_id = jsonMap['user_id'] != null ? jsonMap['user_id'].toString() : currentUser.id;
    }catch(e){
      print(e.toString());
      CustomTrace(StackTrace.current, message: e.toString());
    }
  }

  Map toMap(){
    var m = Map<String, dynamic>();
    if(id!=null)
      m['id'] = int.parse(id);
    m['name'] = name;
    m['created_date'] = created_date;
    m['expenses'] = expenses;
    m['user_id'] = user_id;

    return m;
  }
}