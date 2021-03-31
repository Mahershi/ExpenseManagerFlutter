import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:expensemanager/repositories/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<EditProfile>{
  TextEditingController name;
  TextEditingController uname;

  @override
  void initState(){
    super.initState();
    name = TextEditingController(text: currentUser.name);
    uname = TextEditingController(text: currentUser.uname);
  }

  String heading = "Edit Profile";
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
                    heading: heading,
                    color: accentColor,
                    actionIcon: Icons.done,
                    action: (){

                    },
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
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          child: TextFormField(
                            controller: name,
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
                              labelText: "Name",
                              labelStyle: font.merge(
                                TextStyle(
                                  color: primaryColor
                                )
                              ),
                              hintText: "Name",
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
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          child: TextFormField(
                            controller: uname,
                            validator: (value){
                              if (value == null || value.isEmpty){
                                return "Username Required";
                              }else if(value.length < 3 && value.length>10){
                                return "Minimum length 3, Maximum 10";
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
                              labelText: "Username",
                              labelStyle: font.merge(
                                  TextStyle(
                                      color: primaryColor
                                  )
                              ),
                              hintText: "Expense Name",
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
                        InkWell(
                          onTap: (){
                            var param = {
                              'title': "Change Password",
                              "new_user": false
                            };
                            Navigator.of(context).pushNamed('/ChangePassword', arguments: RouteArgument(param:param));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: borderRadius12,
                              border: Border.all(color: grey)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Change Password",
                                  style: font.merge(
                                    TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04
                                    )
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right
                                )
                              ],
                            )
                          ),
                        )
                      ],
                    )
                  )
                )
              )
            ],
          )
        )
      ),
    );
  }
}