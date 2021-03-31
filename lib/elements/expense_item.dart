import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/elements/add_expense_dialog.dart';
import 'package:expensemanager/elements/confirm_alert.dart';
import 'package:expensemanager/elements/slidablebutton.dart';
import 'package:expensemanager/elements/your_clusters.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/models/route_arguement.dart';
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
  // bool detail;
  // bool action;
  // bool large;
  // bool invertColor;

  ExpenseItem({this.expense, this.textColor,});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseItem>{
  SlidableController slidableController = SlidableController();
  @override
  void initState(){
    super.initState();
    // widget.detail = settingsRepo.detail;
    // widget.action = settingsRepo.action;
    // widget.large = settingsRepo.large;
    // widget.invertColor = settingsRepo.invertColor;
  }

  List<Widget> getActions(){
    List<Widget> list = [];

    list.add(
      InkWell(
          onTap: (){
            String new_id = widget.expense.cluster_id;
            String expId = widget.expense.id;
            String old = widget.expense.cluster_id;
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
                ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshHome);
                ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterDetail);
              }
            });
          },
          child: SlidableButton(value:  widget.expense.cluster_id != null ? "Change Cluster" : "Assign Cluster", fontSize: MediaQuery.of(context).size.width * 0.026, bgColor: settingsRepo.invertColor ? accentColor : primaryColor, txtColor:  settingsRepo.invertColor ? black: accentColor,)
      ),
    );

    if(widget.expense.cluster_id != null){
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
                    ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshHome);
                    ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterDetail);
                  }
                }
              });
            },
            child: SlidableButton(value: "Remove from Cluster", fontSize: MediaQuery.of(context).size.width * 0.026, bgColor: settingsRepo.invertColor ? accentColor : primaryColor, txtColor:  settingsRepo.invertColor ? black: accentColor,)
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      actions: settingsRepo.action ? getActions() : null,
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
                  await exRepo.deleteExpense(widget.expense.id, context);
                  slidableController.activeState.close();
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshExpenseDetail);
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshHome);
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterDetail);
                }
              }
            });
          },
          child: SlidableButton(value: "Delete", fontSize: MediaQuery.of(context).size.width * 0.026,  bgColor: settingsRepo.invertColor ? accentColor : primaryColor, txtColor:  settingsRepo.invertColor ? black: accentColor,),
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.22,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: settingsRepo.large ? 20 : 10, horizontal: 20),
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
                      onTap: () async{
                        await Navigator.of(context).pushNamed('/AddExpense', arguments: RouteArgument(param: widget.expense)).then((value) async{
                          if(value != false){
                            await exRepo.saveExpense(value, context).then((value){
                              print("Value:  " + value.toString());
                              if(value){
                                if (settingsRepo.detail) {
                                  print("trigger detail");
                                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshHome);
                                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshExpenseDetail);
                                } else {
                                  print("trigger cluster");
                                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterDetail);
                                }
                              }

                            });
                          }
                        });
                        // showDialog(
                        //   context: context,
                        //   builder: (context){
                        //     return AddExpenseDialog(expense: widget.expense, title: "Edit Expense",);
                        //   }
                        // ).then((value) async {
                        //   if(value == null)
                        //     value = false;
                        //   print("Value here");
                        //   if(value != false){
                        //     await exRepo.saveExpense(value, context).then((value){
                        //       print("Value:  " + value.toString());
                        //       if(value){
                        //           if (settingsRepo.detail) {
                        //             print("trigger detail");
                        //             ExpenseBloc.expEventSink
                        //                 .add(ExpenseEvent.RefreshHome);
                        //             ExpenseBloc.expEventSink
                        //                 .add(ExpenseEvent.RefreshExpenseDetail);
                        //           } else {
                        //             print("trigger cluster");
                        //             ExpenseBloc.expEventSink
                        //                 .add(ExpenseEvent.RefreshClusterDetail);
                        //           }
                        //         }
                        //
                        //     });
                        //
                        //   }
                        //
                        // });
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
                                widget.expense.name ?? "",
                                style: font.merge(
                                  TextStyle(
                                    color: widget.textColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.04
                                  )
                                ),
                              ),
                            ),
                            Visibility(
                              visible: settingsRepo.detail,
                              child: SizedBox(height: 5,)
                            ),
                            Visibility(
                              visible: settingsRepo.detail,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    child: Text(
                      "₹ " + widget.expense.amount ?? "",
                      style: font.merge(
                          TextStyle(
                              color: widget.textColor,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              letterSpacing: amountspacing
                          )
                      ),
                    )
                ),
                Visibility(
                    visible: settingsRepo.detail,
                    child: SizedBox(height: 5,)
                ),
                Visibility(
                  visible: settingsRepo.detail,
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        settingsRepo.detail ? widget.expense.cluster_id != null ? clusterRepo.getClusterById(widget.expense.cluster_id) != null ? clusterRepo.getClusterById(widget.expense.cluster_id).name : "" : "" : "",
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