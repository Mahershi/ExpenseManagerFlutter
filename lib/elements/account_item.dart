import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget{
  IconData myIcon;
  String text;

  AccountItem({this.text, this.myIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: borderRadius30
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor
            ),
            child: Icon(
              myIcon,
              size: MediaQuery.of(context).size.width * 0.06,
              color: white,
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Text(
              text,
              style: font.merge(
                TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: primaryColor
                )
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: primaryColor,
            size: MediaQuery.of(context).size.width * 0.06,
          )
        ],
      )
    );
  }
}