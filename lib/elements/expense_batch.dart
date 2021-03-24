import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/cupertino.dart';

class ExpenseBatch extends StatefulWidget{
  List<ExpenseModel> expenses;
  ExpenseBatch({this.expenses});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseBatch>{
  DateTime today;
  String todayString;
  String title;
  int total = 0;
  @override
  void initState(){
    super.initState();
    today = DateTime.now();
    todayString = today.toString().substring(0, 10);
    title = widget.expenses[0].expense_date.substring(0, 10) == todayString ? "Today" : today;
    calculateTotal();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text(
                   title,
                  style: font.merge(
                    TextStyle(

                    )
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                 total.toString(),
                  style: font.merge(
                      TextStyle(

                      )
                  ),
                ),
              ],
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.expenses.length,
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.all(10),
                  height: 10,
                  color: primaryColor,
                );
              },
            ),
          )
        ],
      )
    );
  }

  void calculateTotal(){
    for(var i in widget.expenses){
      total += int.parse(i.amount);
    }
    if(mounted)
      setState(() {

      });
  }
}