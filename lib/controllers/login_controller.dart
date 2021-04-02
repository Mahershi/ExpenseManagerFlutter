import 'dart:convert';

import 'package:expensemanager/elements/loader.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expensemanager/helpers/FToastHelper.dart';
import 'package:expensemanager/helpers/firebase.dart' as fb;

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

  Future<void> googleLoginIn(context) async{
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        context: context,
        builder: (context){
          return Loading(color: accentColor,);
        }
    );
    var result = await fb.googleSignInProcess();
    Navigator.of(context).pop();
    if(result != null){
      var res = await userRepo.isExist(result.email, context);
      if(res['success'] == "true"){
        print("res not false");
        userRepo.currentUser = UserModel.fromJson(res['data']);
        print("CU");
        print(userRepo.currentUser.toMap().toString());
        userRepo.saveToSP();
        Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
      }else{
        Navigator.of(context).pushNamed('/SignupPage');
      }
    }
  }
}

