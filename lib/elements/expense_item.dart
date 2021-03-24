import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatefulWidget{
  // IconData myIcon;
  // String text;
  // int value;
  ExpenseModel expense;
  Color textColor;

  ExpenseItem({this.expense, this.textColor});
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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  color: widget.textColor,
                )
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Text(
                  widget.expense.name,
                  style: font.merge(
                    TextStyle(
                      color: widget.textColor,
                      fontSize: MediaQuery.of(context).size.width * 0.04
                    )
                  ),
                ),
              )
            ],
          ),
          Container(
            child: Text(
              "₹ " + widget.expense.amount,
              style: font.merge(
                  TextStyle(
                      color: widget.textColor,
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