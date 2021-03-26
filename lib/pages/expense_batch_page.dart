import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/controllers/expense_batch_controller.dart';
import 'package:expensemanager/controllers/home_controller.dart';
import 'package:expensemanager/elements/expense_batch.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingRepo;

class ExpenseBatchPage extends StatefulWidget{
  var con;
  var type;

  ExpenseBatchPage({this.con, this.type = settingRepo.SortType.DATE});
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
        itemCount: widget.type == settingRepo.SortType.DATE ? widget.con.expenseList.length : widget.con.pieData.length,
        itemBuilder: (context, index){
          String key;
          if(widget.type == settingRepo.SortType.DATE)
            key = widget.con.expenseList.keys.elementAt(index);
          else
            key = widget.con.pieData.keys.elementAt(index);
          print("KEYYYYYYYYYYYYYYYY: " + key);

          return ExpenseBatch(expenses: widget.type == settingRepo.SortType.DATE ? widget.con.expenseList[key] : widget.con.pieData[key], type: widget.type,);
        },
      ),
    );
  }
}