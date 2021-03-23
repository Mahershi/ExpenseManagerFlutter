import 'dart:convert';

import 'package:expensemanager/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends ControllerMVC{
  Future<void> registerUser(uname, name, email, password, context) async {
    var resp = await userRepo.registerUser(name, uname, password, email, context);
    print("got");
    print(resp.toString());

    if(resp['success'] == 'true'){
      userRepo.currentUser = UserModel.fromJson(resp['data']['user'], auth_token: resp['data']['auth_token']);
      print("Registered User");
      print(userRepo.currentUser.saveToSP().toString());
      userRepo.saveToSP();
      Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
    }
  }
}