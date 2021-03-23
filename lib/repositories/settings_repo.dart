//this repo will work for settings model which will have values to be accessible globally
import 'package:expensemanager/network/rest_service.dart';
import 'package:expensemanager/network/APIs.dart';

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