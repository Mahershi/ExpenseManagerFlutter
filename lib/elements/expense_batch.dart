import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/elements/expense_item.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class ExpenseBatch extends StatefulWidget{
  List<ExpenseModel> expenses;
  var type;
  bool detail;
  ExpenseBatch({this.expenses, this.type, this.detail});
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
    // if()
    //   title = ;
    // else
    //   title =
    // print("TITLE: " + title);
    calculateTotal();
  }

  @override
  void didUpdateWidget(ExpenseBatch oldWidget) {
    super.didUpdateWidget(oldWidget);
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.expenses.length);
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: primaryColor,
                borderRadius: borderRadius20
              ),
            // margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.type == settingsRepo.SortType.DATE
                      ? widget.expenses[0].expense_date.substring(0, 10) == todayString ? "Today" : widget.expenses[0].expense_date.substring(0, 10)
                      : settingsRepo.getCategoryById(widget.expenses[0].category_id).name,
                      style: font.merge(
                        TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w800,
                          color: accentColor
                        )
                      ),
                    ),
                    // SizedBox(width: 10,),
                    Text(
                      "₹ " + total.toString(),

                      style: font.merge(
                          TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                              letterSpacing: amountspacing,
                              fontWeight: FontWeight.w800,
                              color: accentColor
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                Visibility(
                  visible: widget.type == settingsRepo.SortType.DATE,
                  child: Text(
                    weekDay[DateTime.parse(widget.expenses[0].expense_date).weekday],
                    style: font.merge(
                        TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w300,
                            color: accentColor
                        )
                    ),
                  ),
                ),
              ],
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemCount: widget.expenses.length,
              itemBuilder: (context, index){
                return ExpenseItem(expense: widget.expenses[index], textColor: primaryColor,);
              },
            ),
          )
        ],
      )
    );
  }

  void calculateTotal(){
    total = 0;
    for(var i in widget.expenses){
      // print("Total: " + total.toString());
      total += int.parse(i.amount);
      // print("Total: " + total.toString());
    }
    setState(() {
    });
  }
}