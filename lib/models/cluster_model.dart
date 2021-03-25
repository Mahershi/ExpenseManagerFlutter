import 'package:expensemanager/helpers/custom_trace.dart';

class ClusterModel{
  String id;
  String name;
  String created_date;
  String expenses;

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
    }catch(e){
      print(e.toString());
      CustomTrace(StackTrace.current, message: e.toString());
    }
  }

  Map toMap(){
    var m = Map<String, dynamic>();
    m['id'] = int.parse(id);
    m['name'] = name;
    m['created_date'] = created_date;
    m['expenses'] = expenses;

    return m;
  }
}