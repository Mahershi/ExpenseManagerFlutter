import 'package:expensemanager/controllers/expensedetail_controller.dart';
import 'package:expensemanager/elements/expense_main_batch.dart';
import 'package:flutter/cupertino.dart';

class ExpenseList extends StatefulWidget{
  ExpenseDetailController con;

  ExpenseList({this.con});

  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseList>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.con.expenseList.length,
        itemBuilder: (context, index){
          String key = widget.con.expenseList.keys.elementAt(index);
          return ExpenseMainBatch(date: key, expenses: widget.con.expenseList[key],);
        },
      ),
    );
  }
}