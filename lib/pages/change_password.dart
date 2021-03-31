import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:expensemanager/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;

class ChangePassword extends StatefulWidget{
  RouteArgument routeArgument;


  ChangePassword({this.routeArgument});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ChangePassword>{
  String heading = "Change Password";
  String title;
  final formKey = GlobalKey<FormState>();
  bool newUser = false;
  UserModel user;

  TextEditingController password = TextEditingController();

  @override
  void initState(){
    super.initState();
    title = widget.routeArgument.param['title'];
    if(widget.routeArgument.param['new_user']){
      newUser = true;
      user = widget.routeArgument.param['user'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: primaryColor,
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.1 + 20,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: BackbuttonAppBar(
                        heading: title,
                        color: accentColor,
                        actionIcon: Icons.done,
                        action: () async{
                          FocusScope.of(context).unfocus();
                          if(formKey.currentState.validate()){
                            if(!newUser) {
                              await userRepo.setPassword(password.text, context).then((value) {
                                if (value) {
                                  Navigator.of(context).pop();
                                }
                              });
                            }
                          }
                        },
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Form(
                        key: formKey,
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
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                      child: TextFormField(
                                        controller: password,
                                        validator: (value){
                                          if (value == null || value.isEmpty){
                                            return "Name Required";
                                          }
                                          else if(value.length > 30){
                                            return "Max 20 Characters";
                                          }
                                          return null;
                                        },
                                        textAlign: TextAlign.center,
                                        style: font.merge(TextStyle(
                                            fontSize: MediaQuery.of(context).size.width * 0.045,

                                            color: primaryColor,
                                            letterSpacing: 1.4,
                                            fontWeight: FontWeight.w800)),
                                        decoration: InputDecoration(
                                          labelText: "New Password",
                                          labelStyle: font.merge(
                                              TextStyle(
                                                  color: primaryColor
                                              )
                                          ),
                                          hintText: "New Password",
                                          hintStyle: font.merge(
                                              TextStyle(color: grey, letterSpacing: 1.2)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: borderRadius12,
                                              borderSide: BorderSide(color: grey)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: borderRadius12,
                                              borderSide: BorderSide(color: primaryColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: borderRadius12,
                                              borderSide: BorderSide(color: red)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: borderRadius12,
                                              borderSide: BorderSide(color: primaryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            )
                        ),
                      )
                  )
                ],
              )
          )
      ),
    );
  }
}