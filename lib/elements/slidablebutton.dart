import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';

class SlidableButton extends StatelessWidget{
  String value;
  double fontSize;

  SlidableButton({this.value, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10,),
        decoration: BoxDecoration(
            borderRadius: borderRadius20,
            color: white
        ),
        padding: EdgeInsets.all(8),
        child: Text(
          value,
          style: font.merge(
              TextStyle(
                  fontSize: fontSize
              )
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
}