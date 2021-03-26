import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/elements/colorsetting.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class SettingsPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<SettingsPage> with RouteAware{
  String heading = "Settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: MediaQuery.of(context).size.height * 0.1 + 20,
              width: MediaQuery.of(context).size.width,
              child: BackbuttonAppBar(
                heading: heading,
                color: accentColor,
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: accentColor
                ),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ColorSetting(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}