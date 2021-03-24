//this repo will work for settings model which will have values to be accessible globally
import 'dart:async';

import 'package:expensemanager/helpers/utilities.dart';
import 'package:expensemanager/models/category_model.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'package:expensemanager/network/APIs.dart';

List<CategoryModel> categories = List<CategoryModel>();

Future<bool> testConnection(context) async{
  var resp = await RestService.request(
      context: context,
      endpoint: API.test,
      authRequired: false
  );
  print(resp.toString());
  if(resp['success'] == 'true'){
    return true;
  }
  else
    return false;
}

Future<void> getCategories(context) async{
  var resp = await RestService.request(
    context: context,
    endpoint: API.categories,
    authRequired: false
  );
  if(resp['success'] == 'true'){
    for(var i in resp['data']){
      var c = CategoryModel.fromJson(i);
      categories.add(c);
    }
  }
  for(var i in categories){
    print(i.toMap().toString());
  }
}