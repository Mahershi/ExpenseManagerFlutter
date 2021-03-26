import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/controllers/clustercontroller.dart';
import 'package:expensemanager/elements/add_expense_dialog.dart';
import 'package:expensemanager/elements/no_expenses.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:expensemanager/pages/expense_batch_page.dart';
import 'package:expensemanager/repositories/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ClusterDetail extends StatefulWidget{
  RouteArgument routeArgument;

  ClusterDetail({this.routeArgument});
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<ClusterDetail>{
  ClusterModel cluster;
  ClusterController _con;

  PageState() : super(ClusterController()){
    _con = controller;
  }

  @override
  void initState(){
    super.initState();
    cluster = widget.routeArgument.param as ClusterModel;
    _con.currentCluster = cluster;
    _con.getExpensesForClusterId(context, _con.currentCluster.id);
    ExpenseBloc.expEventStream.listen((event){
      if(event == ExpenseEvent.RefreshClusterDetail){
        _con.getExpensesForClusterId(context, _con.currentCluster.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: primaryColor,
        child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.1 + 20,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: white),
                                borderRadius: borderRadius12
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: white,
                            )
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                                cluster.name,
                                style: font.merge(
                                    TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.06,
                                        color: white.withOpacity(0.6)
                                    )
                                ),
                              )
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                                child: Text(
                                  "₹ " + (_con.total.toString()),
                                  style: font.merge(
                                      TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.045,
                                          color: white
                                      )
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: white
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _con.expenseList.isNotEmpty ? ExpenseBatchPage(con: _con) : NoExpenses(textColor: primaryColor,),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context){
                      ExpenseModel e = ExpenseModel.createForCluster(cluster.id);
                      return AddExpenseDialog(expense: e, title: "Add Expense",);
                    },
                  ).then((value){
                    print("visible");
                    if(value == null)
                      value = false;
                    if(value){
                      ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterDetail);
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor
                  ),
                  child: Icon(
                    Icons.add,
                    size: MediaQuery.of(context).size.width * 0.08,
                    color: white,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}