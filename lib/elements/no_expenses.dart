import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';

class NoExpenses extends StatelessWidget{
  String text;
  Color textColor;

  NoExpenses({this.textColor, this.text="No Expenses Found!"});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: testBorder
      ),
      child: Text(
        text,
        style: font.merge(
          TextStyle(
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.045
          )
        ),
      )
    );
  }
}