import 'package:expensemanager/controllers/login_controller.dart';
import 'package:expensemanager/custompaints/right_top_curve.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginPage extends StatefulWidget {
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<LoginPage> {
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController uname = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginController _con;

  PageState() : super(LoginController()){
    _con = controller;
  }

  @override
  void initState(){
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
                child: CustomPaint(
                  painter: RightTopCurve(myColor: primaryColor),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                color: secondColor.withOpacity(0.4),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: font.merge(
                                    TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.width * 0.09,
                                      color: primaryColor
                                    )
                                ),
                              ),
                              Text(
                                "There!",
                                style: font.merge(
                                    TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.width * 0.09,
                                      color: primaryColor
                                    )
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Text(
                              //   "Lets get you started.",
                              //   style: font.merge(
                              //     TextStyle(
                              //       fontSize: MediaQuery.of(context).size.width * 0.04,
                              //       color: primaryColor,
                              //     )
                              //   ),
                              // )
                            ],
                          )
                        ),
                        Expanded(
                          child: Container(
                              // decoration: BoxDecoration(border: testBorder),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 12),
                                      child: Text(
                                        "Keep track of all your expenses...",
                                        textAlign: TextAlign.right,
                                        style: font.merge(
                                            TextStyle(
                                                fontSize:
                                                MediaQuery.of(context).size.width * 0.04,
                                                color: primaryColor
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: loginFormKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: TextFormField(
                                            controller: uname,
                                            validator: (value){
                                              if (value == null || value.isEmpty){
                                                return "Username Required";
                                              }
                                              return null;
                                            },
                                            textAlign: TextAlign.center,
                                            style: font.merge(
                                                TextStyle(
                                                    color: primaryColor,
                                                    letterSpacing: 1.4,
                                                    fontWeight: FontWeight.w800
                                                )
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Username",
                                              hintStyle: font.merge(
                                                  TextStyle(color: grey, letterSpacing: 1.2,)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: primaryColor)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: accentColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: red)),
                                              focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: accentColor)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: TextFormField(
                                            controller: password,
                                            validator: (value){
                                              if (value == null || value.isEmpty){
                                                return "Password Required";
                                              }
                                              return null;
                                            },
                                            textAlign: TextAlign.center,
                                            style: font.merge(TextStyle(
                                                color: primaryColor,
                                                letterSpacing: 1.4,
                                                fontWeight: FontWeight.w800)),
                                            decoration: InputDecoration(
                                              hintText: "Password",
                                              hintStyle: font.merge(
                                                  TextStyle(color: grey, letterSpacing: 1.2)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: primaryColor)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: accentColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: red)),
                                              focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: borderRadius12,
                                                  borderSide: BorderSide(color: accentColor)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(loginFormKey.currentState.validate()){
                                        print("logging");
                                        _con.login(uname.text, password.text, context);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: borderRadius12,
                                          color: primaryColor),
                                      child: Text(
                                        "Sign In",
                                        style: font.merge(TextStyle(
                                            color: accentColor,
                                            fontSize:
                                                MediaQuery.of(context).size.width * 0.042,
                                            letterSpacing: 1.2)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: (){
                              print("pressed");
                              Navigator.of(context).pushNamed('/SignupPage');
                            },
                            child: Container(
                              // decoration: BoxDecoration(border: testBorder),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "New here?",
                                    style: font.merge(
                                        TextStyle(
                                            color: primaryColor,
                                            fontSize: MediaQuery.of(context).size.width * 0.03,
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.w800
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Sign UP",
                                    style: font.merge(
                                      TextStyle(
                                        color: primaryColor,
                                        fontSize:
                                        MediaQuery.of(context).size.width * 0.03,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w800
                                      )
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 0.5,
                                color: primaryColor.withOpacity(0.8),
                              ),
                              Text(
                                  "OR",
                                style: font.merge(TextStyle(
                                    color: primaryColor,
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                    letterSpacing: 1.2)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                color: primaryColor.withOpacity(0.8),
                                height: 0.5,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            // width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: borderRadius12,
                                border: Border.all(color: primaryColor.withOpacity(0.6))
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/img/google.png',
                                  width: MediaQuery.of(context).size.width * 0.07,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Sign In with Google",
                                  style: font.merge(
                                      TextStyle(
                                          color: primaryColor,
                                          fontSize: MediaQuery.of(context).size.width * 0.042
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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
