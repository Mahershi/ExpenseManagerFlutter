import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:expensemanager/elements/loader.dart';
import 'package:expensemanager/helpers/FToastHelper.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../app_config.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;

class RestService {
  static Dio dio;
  static String baseUrl = AppConfig.config.baseUrl;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ))
      ..interceptors.add(AppInterceptors());
    print(baseUrl.toString());
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("Request Data ${options.data}");
      print("RequestPath ${options.path}");
      print("Request QP ${options.queryParameters}");
      print("RequestORP ${options.onReceiveProgress}");
      return options; //continue
    }, onResponse: (Response response) async {
      print("Response DATA${response.data}");
      return response; // continue
    }, onError: (DioError e) async {
      print("Calling EMSG${e.message}");
      print("Calling ETYPE${e.type}");
      print("Calling ERES${e.response}");
      // Do something with response error
      return e; //continue
    }));
  }


  static Future<dynamic> request(
      {@required BuildContext context,
        @required String endpoint,
        String method = 'GET',
        bool authRequired = true,
        Map<String, dynamic> queryParameters = const {},
        dynamic data = const {},
        bool showError = false,
        bool showLoader = false,
        bool showSuccess = false,
        Color loaderColor}) async {
    try {
      // if (AppConfig.config.environment == 'staging') {
      //   print('Calling: ${method.padLeft(4, ' ')} $endpoint');
      // }
      String language = 'es';

      Options _cacheOptions = Options();
      _cacheOptions.method = method;
      _cacheOptions.headers = {
        'accept-language': language,
        'authrequired': authRequired
      };


      if(showLoader && context !=null ){
        var t = showDialog(
          barrierColor: Colors.transparent,
          barrierDismissible: false,
          context: context,
          builder: (context){
            return Loading(color: loaderColor,);
          }
        );
      }
      // print(_cacheOptions.headers.toString());
      Response<dynamic> response = await dio.request(
        '$endpoint',
        data: data,
        queryParameters: queryParameters,
        options: _cacheOptions,
      );
      if(showLoader && context != null){
        print("popping loader");
        Navigator.of(context).pop();
      }
      var apiResponJson = response.data;
      var json = jsonDecode(response.toString());
      print(response.statusCode);
      print("RES:" + apiResponJson.toString());
      if (json['success'] == "true" || response.statusCode == 200 || response.statusCode == 201) {
        // print("Success");
        if(showSuccess && context != null){
          CustomToast(context: context, msg: response.data['message'] ?? "", msgColor: primaryColor).showToast();
        }
        return response.data;
      } else {
        // print("Server Error");
        if(showSuccess && context != null){
          var err = response.data['error'] ?? "";
          CustomToast(context: context, msg: err is String ? err : "", msgColor: primaryColor).showToast();
        }
        return response.data;
      }
    } on DioError catch (e) {
      if(showLoader && context != null){
        print("popping loader");
        Navigator.of(context).pop();
      }
      String erMsg = 'Connection Error';
      String erMsg2 = '';
      if(e.response != null){
        switch(e.response.statusCode){
          case 401:
            erMsg = "Invalid Credentials";
            break;
          case 500:
            erMsg = "Server Error";
            break;
          default:
            erMsg = "Unknown Error";
        }
        var l = e.response.data['error'];
        if(l is List<dynamic>){
          erMsg2 = l[0]['message'][0].toString();
        }
      }
      // print(erMsg2.runtimeType);
      CustomToast(context: context, msg: erMsg2 == '' ? erMsg : erMsg2, msgColor: red,).showToast();
      return {
        "success": "false",
        "error": erMsg2 == '' ? erMsg : erMsg2
      };
    } catch(e){
      CustomToast(context: context, msg: "Connection Error", msgColor: red).showToast();
      return {
        "success": "false",
        "error": "Connection Error"
      };
    }
  }
}

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    options.headers.addAll({
      'x-client-id': AppConfig.config.clientId,
      'x-client-device': AppConfig.config.clientDevice,
    });

    if (options.headers['authrequired'] == 'true') {
      options.headers.remove("authrequired");
      options.headers.addAll({
        'Authorization': 'Token ' + userRepo.currentUser.authToken
      });

      return options;
    }else{
      options.headers.remove('authrequired');
    }
    print(options.headers.toString());
  }

}
