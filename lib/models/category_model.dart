import 'package:expensemanager/helpers/custom_trace.dart';

class CategoryModel{
  String id;
  String name;
  String imageUrl;

  CategoryModel.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "0";
      name = jsonMap['name'] != null ? jsonMap['name'].toString() : "None";
      imageUrl = jsonMap['image_url'] ?? '';
    }catch(e){
      print(e.toString());
      CustomTrace(StackTrace.current, message: e.toString());
    }
  }

  Map toMap(){
    var m = Map<String, dynamic>();
    m['id'] = int.parse(id);
    m['name'] = name;
    m['image_url'] = imageUrl;

    return m;
  }
}