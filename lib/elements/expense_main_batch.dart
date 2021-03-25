import 'package:expensemanager/elements/expense_item.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/cupertino.dart';

class ExpenseMainBatch extends StatefulWidget{
  String date;
  List<ExpenseModel> expenses;

  ExpenseMainBatch({this.date, this.expenses});

  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseMainBatch>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(topRight: radius12, bottomRight: radius12)
            ),
            child: Text(
              widget.date,
              style: font.merge(
                TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: primaryColor
                )
              ),
            )
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            itemCount: widget.expenses.length,
            itemBuilder: (context, index){
              return ExpenseItem(expense: widget.expenses[index], textColor: white, detail: true,);
            },
          ),

        ],
      ),
    );
  }
}