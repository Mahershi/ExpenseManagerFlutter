import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:expensemanager/helpers/FToastHelper.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/material.dart';
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
        bool showErrorInSnackBar = false,
        bool showLoader = true,
        bool isShowSuccessMsg = false}) async {
    try {
      if (AppConfig.config.environment == 'development') {
        print('Calling: ${method.padLeft(4, ' ')} $endpoint');
      }
      String language = 'es';

      Options _cacheOptions = Options();
      _cacheOptions.method = method;
      _cacheOptions.headers = {
        'accept-language': language,
        'authrequired': authRequired
      };

      print(_cacheOptions.headers.toString());
      Response<dynamic> response = await dio.request(
        '$endpoint',
        data: data,
        queryParameters: queryParameters,
        options: _cacheOptions,
      );

      var apiResponJson = response.data;
      print("response url $baseUrl$endpoint");
      var json = jsonDecode(response.toString());
      print(response.statusCode);
      if (json['success'] == "true" || response.statusCode == 200) {
        print("Success");
        return response.data;
      } else {
        print("Server Error");
        return response.data;
      }
    } on DioError catch (e) {

      String erMsg = '';
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
      CustomToast(context: context, msg: erMsg, msgColor: red).showToast();
      return {
        "success": "false",
        "error": erMsg
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
