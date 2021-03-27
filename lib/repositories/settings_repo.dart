//this repo will work for settings model which will have values to be accessible globally
import 'dart:async';

import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/helpers/utilities.dart';
import 'package:expensemanager/models/category_model.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'package:expensemanager/network/APIs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
enum SortType {DATE, CATEGORY}
List<CategoryModel> categories = List<CategoryModel>();
int colorIndex = 0;

bool action = false;
bool large = false;
bool detail = false;
bool invertColor = true;

Future<bool> testConnection(context) async{
  var resp = await RestService.request(
      context: context,
      endpoint: API.test,
      authRequired: false
  );
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
}

CategoryModel getCategoryById(id){
  for(var i in categories){
    if(i.id == id)
      return i;
  }
}

Future<void> getColorIndex() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if(preferences.containsKey('color')){
    colorIndex = preferences.getInt('color');
  }
  primaryColor = primaryColors[colorIndex];
  accentColor = accentColors[colorIndex];
  secondColor = secondColors[colorIndex];
}

Future<void> saveColorIndex(index) async {
  colorIndex = index;
  primaryColor = primaryColors[index];
  accentColor = accentColors[index];
  secondColor = secondColors[index];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('color', colorIndex);
}