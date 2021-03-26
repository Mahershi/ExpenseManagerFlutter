import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';

class SlidableButton extends StatelessWidget{
  String value;
  double fontSize;
  Color txtColor;
  Color bgColor;

  SlidableButton({this.value, this.fontSize, this.txtColor, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.symmetric(vertical: 10,),
        decoration: BoxDecoration(
            borderRadius: borderRadius20,
            color: bgColor
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Text(
          value,
          style: font.merge(
              TextStyle(
                  fontSize: fontSize,
                color: txtColor
              )
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
}