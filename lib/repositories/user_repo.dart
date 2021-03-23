import 'dart:convert';

import 'package:expensemanager/models/user_model.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'package:expensemanager/network/APIs.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    data: data
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
      data: data
  );
  return resp;

}

Future<void> saveToSP() async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String s = json.encode(currentUser.saveToSP());
  _pref.setString('user', json.encode(currentUser.saveToSP()));
  print("Saved User to SP");
  print(s);
}

Future<void> getFromSP() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  var user = await pref.get('user');
  currentUser = UserModel.fromJson(json.decode(user));
  print("Fetched User from SP");
  print(currentUser.saveToSP().toString());
}

