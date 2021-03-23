import 'package:expensemanager/helpers/custom_trace.dart';

class UserModel{
  String authToken = '';

  String id;
  String name;
  String uname;
  String email;
  String password;
  String fcmToken;
  String dateJoined;
  String imageUrl;
  bool isSuperUser = false;

  UserModel();

  UserModel.fromJson(jsonMap, {authToken = ''}){
    print("rcv in model");
    print(jsonMap.toString());
    authToken = authToken;

    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      name = jsonMap['name'] ?? '';
      uname = jsonMap['uname'] ?? '';
      email = jsonMap['email'] ?? '';
      password = jsonMap['password'] ?? '';
      fcmToken = jsonMap['fcm_token'] ?? '';
      dateJoined = jsonMap['date_joined'] ?? '';
      imageUrl = jsonMap['image_url'] ?? '';
      isSuperUser = jsonMap['is_superuser'] ?? false;
    }
    catch(e){
      print("error:" + e.toString());
      CustomTrace(StackTrace.current, message: e.toString());
    }
  }

  Map toMap(){
    var m = Map<String, dynamic>();
    m['id'] = id;
    m['name'] = name;
    m['uname'] = uname;
    m['email'] = email;
    // m['password'] = password;
    m['auth_token'] = authToken;
    m['fcm_token'] = fcmToken;
    m['is_superuser'] = isSuperUser;
    m['date_joined'] = dateJoined;
    m['image_url'] = imageUrl;

    return m;
  }

  Map saveToSP(){
    var m = Map<String, dynamic>();
    m['id'] = id;
    m['name'] = name;
    m['uname'] = uname;
    m['email'] = email;
    m['password'] = password;
    m['auth_token'] = authToken;
    m['fcm_token'] = fcmToken;
    m['is_superuser'] = isSuperUser;
    m['date_joined'] = dateJoined;
    m['image_url'] = imageUrl;

    return m;
  }
}