import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expensemanager/models/user_model.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class SplashScreenController extends ControllerMVC{

  Future<bool> testConnection(context) async{
    return await settingsRepo.testConnection(context);
  }

  Future<bool> checkLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.containsKey('user')){
      var user = await pref.get('user');
      print(user.runtimeType);
      print(user);
      userRepo.currentUser = UserModel.fromJson(json.decode(user));
      print("Fetched User from SP");
      print(userRepo.currentUser.saveToSP().toString());
      return true;
    }else{
      return false;
    }
  }
}