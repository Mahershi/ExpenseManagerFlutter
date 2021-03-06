import 'dart:convert';

import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/user_model.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'package:expensemanager/network/APIs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expensemanager/helpers/firebase.dart' as fb;

UserModel currentUser = UserModel();

Future<void> fetchCurrentUser(String uname, String password){

}

Future<dynamic> loginUser(String uname, String password, context) async {
  Map<String, dynamic> data = {
    'username': uname,
    'password': password
  };
  var resp = await RestService.request(
    context: context,
    endpoint: API.login,
    authRequired: false,
    method: 'POST',
    data: data,
    showLoader: true,
    loaderColor: accentColor
  );
  return resp;
}

Future<dynamic> registerUser(String name, String uname, String password, String email, context) async{
  var data = {
    'uname': uname,
    'password': password,
    'name': name,
    'email': email
  };

  var resp = await RestService.request(
      context: context,
      endpoint: API.register,
      authRequired: false,
      method: 'POST',
      data: data,
    showLoader: true,
    loaderColor: accentColor
  );
  return resp;

}

Future<void> saveToSP() async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String s = json.encode(currentUser.saveToSP());
  _pref.setString('user', json.encode(currentUser.saveToSP()));
}

Future<void> getFromSP() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  var user = await pref.get('user');
  currentUser = UserModel.fromJson(json.decode(user));
}
Future<bool> setPassword(String password, context) async{
  String api = API.change_password;
  api += '/${currentUser.id}/';
  String method = 'PUT';
  var data = {
    'password': password
  };

  var resp = await RestService.request(
    context: context,
    endpoint: api,
    data: data,
    method: method,
    showLoader: true,
    loaderColor: primaryColor,
    authRequired: false,
    showError: true,
    showSuccess: true
  );

  print(resp.toString());
  return resp['success'] == "true";
}

Future<dynamic> isExist(email, context) async{
  var data = {
    "email": email
  };
  var resp = await RestService.request(
    context: context,
    endpoint: API.isExistUser,
    data: data,
    authRequired: false,
    method: 'POST',
    showLoader: true,
    loaderColor: accentColor
  );
  return resp;
}

Future<dynamic> googleLoginInRegister(String name, String uname, String password, String email, context) async{
  var data = {
    'uname': uname,
    'password': password,
    'name': name,
    'email': email,
    'image_url': fb.googleUser.photoURL,
  };

  var resp = await RestService.request(
      context: context,
      endpoint: API.register,
      authRequired: false,
      method: 'POST',
      data: data,
      showLoader: true,
      loaderColor: accentColor
  );
  return resp;
}
