import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';

class NoExpenses extends StatelessWidget{
  String text;
  Color textColor;
  String tag;

  NoExpenses({this.textColor, this.text="No Expenses Found!", this.tag});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      decoration: BoxDecoration(
        // border: testBorder
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: font.merge(
              TextStyle(
                color: textColor,
                fontSize: MediaQuery.of(context).size.width * 0.05
              )
            ),
          ),
          Visibility(
            visible: tag != null,
            child: SizedBox(
              height: 20,
            ),
          ),
          Visibility(
            visible: tag != null,
            child: Text(
              tag ?? "",
              textAlign: TextAlign.center,
              style: font.merge(
                  TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: MediaQuery.of(context).size.width * 0.028,
                    height: 1.4
                  )
              ),
            ),
          ),
        ],
      )
    );
  }
}