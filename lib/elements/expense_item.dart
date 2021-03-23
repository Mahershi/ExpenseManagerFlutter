import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatefulWidget{
  IconData myIcon;
  String text;
  int value;

  ExpenseItem({this.myIcon, this.value, this.text});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseItem>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      // margin: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondColor.withOpacity(0.7)
                ),
                // width: MediaQuery.of(context).size.width * 0.09,
                // height: MediaQuery.of(context).size.width * 0.09,
                child: Icon(
                  Icons.home,
                  size: MediaQuery.of(context).size.width * 0.06,
                  color: white,
                )
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Text(
                  widget.text,
                  style: font.merge(
                    TextStyle(
                      color: white,
                      fontSize: MediaQuery.of(context).size.width * 0.04
                    )
                  ),
                ),
              )
            ],
          ),
          Container(
            child: Text(
              "₹ " + widget.value.toString(),
              style: font.merge(
                  TextStyle(
                      color: white,
                      fontSize: MediaQuery.of(context).size.width * 0.04
                  )
              ),
            )
          )
        ],
      )
    );
  }
}