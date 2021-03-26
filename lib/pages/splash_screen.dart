import 'dart:async';

import 'package:expensemanager/controllers/splashscreen_controller.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreen extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<SplashScreen>{
  SplashScreenController _con;

  PageState() : super(SplashScreenController()){
    _con = controller;
  }
  
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
    initializeApp();
  }
  
  Future<void> initializeApp() async{
    var connection = await _con.testConnection(context);
    if(connection){
      _con.getCategories(context);
      var isLoggedIn = await _con.checkLogin();
      if(isLoggedIn){
        Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      }
    }else{
      print("Connection Error");
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text(
          "Expense Manager",
          style: font.merge(
            TextStyle(
                fontSize: splashHeading(context),
                color: accentColor,
                fontWeight: FontWeight.w400
            )
          ),
        )
      )
    );
  }
}