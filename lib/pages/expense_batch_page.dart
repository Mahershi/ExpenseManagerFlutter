import 'package:expensemanager/controllers/expense_batch_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ExpenseBatchPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<ExpenseBatchPage>{
  ExpenseBatchController _con;

  PageState() : super(ExpenseBatchController()){
    _con = controller;
  }

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(

      )
    );
  }
}