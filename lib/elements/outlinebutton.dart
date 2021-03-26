import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  Function onpressed;
  String text;
  Color bgColor;
  Color textColor;
  CustomButton({this.text, this.onpressed, this.bgColor, this.textColor});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onpressed,
      style: OutlinedButton.styleFrom(
          primary: accentColor,
          backgroundColor: bgColor,
          elevation: 1
      ),
      child: Text(
        text,
        style: font.merge(
            TextStyle(
                color: textColor,
                letterSpacing: 1.1,
                fontSize: MediaQuery.of(context).size.width * 0.04
            )
        ),
      ),

    );
  }
}