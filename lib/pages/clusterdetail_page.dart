import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/controllers/clustercontroller.dart';
import 'package:expensemanager/elements/add_expense_dialog.dart';
import 'package:expensemanager/elements/no_expenses.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:expensemanager/pages/expense_batch_page.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;
import 'package:fl_chart/fl_chart.dart';
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
        print("refreshing cluster detail");
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
                                border: Border.all(color: accentColor),
                                borderRadius: borderRadius12
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: accentColor,
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
                                        color: accentColor.withOpacity(0.6)
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
                                          color: accentColor
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
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: accentColor
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        width: MediaQuery.of(context).size.width/1.9,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              child: PieChart(

                                PieChartData(
                                  sections: _con.getSections(context),
                                  sectionsSpace: 12,
                                  startDegreeOffset: 180,
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                    // print(pieTouchResponse.touchedSectionIndex.toString());
                                    // print(pieTouchResponse.touchedSection.toString());
                                    if(pieTouchResponse.touchedSection != null){
                                      if(pieTouchResponse.touchedSectionIndex != _con.touchedIndex){
                                        _con.touchedIndex = pieTouchResponse.touchedSectionIndex;
                                        // print(_con.touchedIndex);
                                      }else{
                                        _con.touchedIndex = -1;
                                      }
                                      // ExpenseBloc.exListStateSink.add(1);
                                      setState(() {
                                        _con.reorder(_con.touchedIndex);
                                      });
                                    }

                                  }),
                                ),
                                swapAnimationDuration: Duration(milliseconds: 150),
                              )
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 40),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _con.getLegend()
                          ),
                        )
                      ),
                      StreamBuilder(
                        stream: ExpenseBloc.exListStateStream,
                        builder: (context, v){
                          return _con.expenseList.isNotEmpty ? ExpenseBatchPage(con: _con, type: _con.touchedIndex != -1 ? settingsRepo.SortType.CATEGORY : settingsRepo.SortType.DATE,) : NoExpenses(textColor: primaryColor, );
                        }
                      )

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
                    color: accentColor,
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