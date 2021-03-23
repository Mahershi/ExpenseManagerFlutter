import 'package:expensemanager/custompaints/curvy_right_top.dart';
import 'package:expensemanager/custompaints/right_top_curve.dart';
import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignupPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<SignupPage> with SingleTickerProviderStateMixin{
  String heading = 'Register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              child: CustomPaint(
                painter: CurvyRightTop(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              )
          ),
          Container(
            color: secondColor.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 20,
                bottom: 20,
                right: 20
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 40
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackbuttonAppBar(heading: heading,),
                    // Container(
                    //     margin: EdgeInsets.symmetric(vertical: 30),
                    //     child: Text(
                    //     "Lets get you started...",
                    //     style: font.merge(
                    //         TextStyle(
                    //           fontSize: MediaQuery.of(context).size.width * 0.045,
                    //           color: primaryColor,
                    //         )
                    //     ),
                    //   )
                    // ),
                    Container(
                        margin: EdgeInsets.only(top: 40, bottom: 10),
                        child: Text(
                          "Lets start with your name",
                          style: font.merge(
                              TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                color: primaryColor,
                              )
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: font.merge(
                            TextStyle(
                                color: primaryColor,
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.w800
                            )
                        ),
                        decoration: InputDecoration(
                          hintText: "Elijah Mikaelson",
                          hintStyle: font.merge(
                              TextStyle(color: grey, letterSpacing: 1.2,)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: white)),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 40, bottom: 10),
                        child: Text(
                          "Your email address...",
                          style: font.merge(
                              TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                color: primaryColor,
                              )
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: font.merge(
                            TextStyle(
                                color: primaryColor,
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.w800
                            )
                        ),
                        decoration: InputDecoration(
                          hintText: "e_mikaleson@theoriginals.com",
                          hintStyle: font.merge(
                              TextStyle(color: grey, letterSpacing: 1.2,)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: white)),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 40, bottom: 10),
                        child: Text(
                          "A fancy username",
                          style: font.merge(
                              TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                color: primaryColor,
                              )
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: font.merge(
                            TextStyle(
                                color: primaryColor,
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.w800
                            )
                        ),
                        decoration: InputDecoration(
                          hintText: "e_mikaelson",
                          hintStyle: font.merge(
                              TextStyle(color: grey, letterSpacing: 1.2,)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: white)),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 40, bottom: 10),
                        child: Text(
                          "A difficult to guess Password",
                          style: font.merge(
                              TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                color: primaryColor,
                              )
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: font.merge(
                            TextStyle(
                                color: primaryColor,
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.w800
                            )
                        ),
                        decoration: InputDecoration(
                          hintText: "elij@hm1000",
                          hintStyle: font.merge(
                              TextStyle(color: grey, letterSpacing: 1.2,)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: white)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: borderRadius12,
                          color: primaryColor),
                      child: Text(
                        "Register",
                        style: font.merge(TextStyle(
                            color: white,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.042,
                            letterSpacing: 1.2)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}