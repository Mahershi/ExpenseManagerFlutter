import 'dart:io';

import 'package:expensemanager/helpers/route_generator.dart';
import 'package:expensemanager/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'app_config.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'helpers/constants.dart';
import 'repositories/settings_repo.dart' as settingsRepo;
import 'helpers/firebase.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setUpConfiguration();
  RestService.init();
  await settingsRepo.getColorIndex();
  initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      navigatorObservers: [settingsRepo.routeObserver],
    );
  }
}

void setUpConfiguration() {
  AppConfig.setEnvironment(Environment.DEVELOPMENT);
  if (Platform.isAndroid) {
    AppConfig.config.clientDevice = Device.ANDROID.toString();
  } else {
    AppConfig.config.clientDevice = Device.IOS.toString();
  }
}