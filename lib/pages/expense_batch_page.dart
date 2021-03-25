import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/controllers/expense_batch_controller.dart';
import 'package:expensemanager/controllers/home_controller.dart';
import 'package:expensemanager/elements/expense_batch.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ExpenseBatchPage extends StatefulWidget{
  var con;

  ExpenseBatchPage({this.con});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseBatchPage>{
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: widget.con.expenseList.length,
        itemBuilder: (context, index){
          String key = widget.con.expenseList.keys.elementAt(index);
          return ExpenseBatch(expenses: widget.con.expenseList[key],);
        },
      ),
    );
  }
}