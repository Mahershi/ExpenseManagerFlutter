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

