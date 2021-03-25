import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/elements/confirm_alert.dart';
import 'package:expensemanager/elements/expense_item.dart';
import 'package:expensemanager/elements/your_clusters.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;

class ExpenseMainBatch extends StatefulWidget{
  String date;
  List<ExpenseModel> expenses;

  ExpenseMainBatch({this.date, this.expenses});

  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpenseMainBatch>{
  SlidableController slidableController = SlidableController();
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
              return Slidable(
                controller: slidableController,
                secondaryActions: [
                  InkWell(
                    onTap: (){
                      String new_id = widget.expenses[index].cluster_id;
                      String expId = widget.expenses[index].id;
                      String old = widget.expenses[index].cluster_id;
                      print("Odl");
                      print(old);
                      showDialog(
                        context: context,
                        builder: (context){
                          return YourClusters(currentId: widget.expenses[index].cluster_id,);
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
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,),
                        decoration: BoxDecoration(
                            borderRadius: borderRadius20,
                            color: white
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Change",
                              style: font.merge(
                                TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.026
                                )
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Cluster",
                              style: font.merge(
                                  TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.026,
                                  )
                              ),
                            ),

                          ],
                        )
                    ),
                  ),
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
                            await clusterRepo.removeExpenseFromCluster(widget.expenses[index], context);
                            slidableController.activeState.close();
                            ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshExpenseDetail);
                          }
                        }
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,),
                        decoration: BoxDecoration(
                            borderRadius: borderRadius20,
                            color: white
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Remove",
                              style: font.merge(
                                  TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.026,
                                    color: red
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "from",
                              style: font.merge(
                                  TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.026,
                                    color: red
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Cluster",
                              style: font.merge(
                                  TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.026,
                                    color: red
                                  )
                              ),
                            ),

                          ],
                        )
                    ),
                  ),
                ],
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.2,
                child: ExpenseItem(expense: widget.expenses[index], textColor: white, detail: true,),
              );
            },
          ),

        ],
      ),
    );
  }
}

