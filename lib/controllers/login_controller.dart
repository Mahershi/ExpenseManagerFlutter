import 'dart:convert';

import 'package:expensemanager/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expensemanager/helpers/FToastHelper.dart';

class LoginController extends ControllerMVC{
  Future<void> login(String uname, String password, context) async{
    var respData = await userRepo.loginUser(uname, password, context);

    if(respData['success'] == 'true'){
      userRepo.currentUser = UserModel.fromJson(respData['data']['user'], auth_token: respData['data']['auth_token']);
      print(userRepo.currentUser.saveToSP().toString());
      userRepo.saveToSP();
      Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
    }else{
      print("Error Loggin IN");
      // CustomToast(context: context, msg: "Invalid Credentials").showToast();
    }
  }
}