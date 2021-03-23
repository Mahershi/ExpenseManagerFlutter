import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackbuttonAppBar extends StatelessWidget{
  String heading;
  Color color;

  BackbuttonAppBar({this.heading = '', this.color=primaryColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: color),
                    borderRadius: borderRadius12
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: color,
                )
            ),
          ),
          Container(
            child: Text(
              heading,
              style: font.merge(
                TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  color: color
                )
              ),
            )
          ),
          Opacity(
            opacity: 0,
            child: Container(
                child: Icon(
                  Icons.chevron_left,
                  color: color,
                )
            ),
          )
        ],
      )
    );
  }
}