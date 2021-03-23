import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast{
  BuildContext context;
  String msg;
  FToast fToast;
  Color msgColor;

  CustomToast({this.context, this.msg, this.msgColor}){
    fToast = FToast();
    fToast.init(context);
  }

  showToast(){
    fToast.showToast(
      child: getToastWidget(),
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 1)
    );
  }

  Container getToastWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: borderRadius20,
        color: white.withOpacity(0.92)
      ),
      child: Text(
        msg,
        style: font.merge(
          TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: msgColor,
            letterSpacing: 1.1
          )
        ),
      )
    );
  }


}