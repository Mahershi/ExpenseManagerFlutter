import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/elements/add_expense_dialog.dart';
import 'package:expensemanager/elements/confirm_alert.dart';
import 'package:expensemanager/elements/slidablebutton.dart';
import 'package:expensemanager/elements/your_clusters.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;

class ExpenseItem extends StatefulWidget{
  // IconData myIcon;
  // String text;
  // int value;
  ExpenseModel expense;
  Color textColor;
  bool detail;

  ExpenseItem({this.expense, this.textColor, this.detail=false});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseItem>{
  SlidableController slidableController = SlidableController();
  @override
  void initState(){
    super.initState();
  }

  List<Widget> getActions(){
    List<Widget> list = [];
    if(widget.detail){
      list.add(
        InkWell(
            onTap: (){
              String new_id = widget.expense.cluster_id;
              String expId = widget.expense.id;
              String old = widget.expense.cluster_id;
              print("Odl");
              print(old);
              showDialog(
                  context: context,
                  builder: (context){
                    return YourClusters(currentId: widget.expense.cluster_id,);
                  }
              ).then((value) async{
                if(value != null && value != false){
                  print("Val: " + value);
                  new_id = value;
                  await clusterRepo.changeCluster(expId, old ?? "0", new_id, context);
                  slidableController.activeState.close();
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshExpenseDetail);
                }
              });
            },
            child: SlidableButton(value: "Change Cluster", fontSize: MediaQuery.of(context).size.width * 0.026, bgColor: widget.detail ? accentColor : primaryColor, txtColor:  widget.detail ? black: accentColor,)
        ),
      );
      list.add(
        InkWell(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return ConfirmAlert(
                      title: "Remove Expense from Cluster?",
                      tag: "This will not delete expense but only remove it from the cluster.",
                      color: red,
                    );
                  }
              ).then((value) async {
                if(value!=null){
                  if(value){
                    await clusterRepo.removeExpenseFromCluster(widget.expense, context);
                    slidableController.activeState.close();
                    ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshExpenseDetail);
                  }
                }
              });
            },
            child: SlidableButton(value: "Remove from Cluster", fontSize: MediaQuery.of(context).size.width * 0.026, bgColor: widget.detail ? accentColor : primaryColor, txtColor:  widget.detail ? black: accentColor,)
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      actions: widget.detail ? getActions() : null,
      secondaryActions: [
        InkWell(
          onTap: (){
            showDialog(
                context: context,
                builder: (context){
                  return ConfirmAlert(
                    title: "Delete Expense?",
                    tag: "Expense will be deleted permanently.",
                    color: red,
                  );
                }
            ).then((value) async {
              if(value!=null){
                if(value){
                  exRepo.deleteExpense(widget.expense.id, context);
                  slidableController.activeState.close();
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshExpenseDetail);
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshHome);
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterDetail);
                }
              }
            });
          },
          child: SlidableButton(value: "Delete", fontSize: MediaQuery.of(context).size.width * 0.026,  bgColor: widget.detail ? accentColor : primaryColor, txtColor:  widget.detail ? black: accentColor,),
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: widget.detail ? 20 : 10, horizontal: 20),
        // margin: EdgeInsets.all(0),
        //   decoration: BoxDecoration(border: testBorder),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                // decoration: BoxDecoration(border: testBorder),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context){
                            return AddExpenseDialog(expense: widget.expense, title: "Edit Expense",);
                          }
                        ).then((value){
                          if(value == null)
                            value = false;
                          print("Value here");
                          if(value){
                            if(widget.detail){
                              print("trigger detail");
                              ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshExpenseDetail);
                            }else{
                              print("trigger main");
                              ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshHome);
                              ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterDetail);

                            }
                          }

                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondColor.withOpacity(0.7),
                        ),
                        // width: MediaQuery.of(context).size.width * 0.09,
                        // height: MediaQuery.of(context).size.width * 0.09,
                        child: Icon(
                          Icons.edit,
                          size: MediaQuery.of(context).size.width * 0.06,
                          color: widget.textColor,
                        )
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            ),
                            Visibility(
                              visible: widget.detail,
                              child: SizedBox(height: 5,)
                            ),
                            Visibility(
                              visible: widget.detail,
                              child: Container(
                                child: Text(
                                  settingsRepo.getCategoryById(widget.expense.category_id).name,
                                  style: font.merge(
                                      TextStyle(
                                          color: widget.textColor.withOpacity(0.6),
                                          fontSize: MediaQuery.of(context).size.width * 0.028
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
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
                ),
                Visibility(
                    visible: widget.detail,
                    child: SizedBox(height: 5,)
                ),
                Visibility(
                  visible: widget.detail,
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.detail ? widget.expense.cluster_id != null ? clusterRepo.getClusterById(widget.expense.cluster_id).name : "" : "",
                        style: font.merge(
                            TextStyle(
                                color: widget.textColor.withOpacity(0.8),
                                fontSize: MediaQuery.of(context).size.width * 0.025
                            )
                        ),
                      )
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}