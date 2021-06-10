import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/controllers/home_controller.dart';
import 'package:expensemanager/elements/no_expenses.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/DataSet.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:expensemanager/pages/expense_batch_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class HomePage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<HomePage> with RouteAware{
  HomeController _con;
  int rawDataIndex = 5;

  PageState() : super(HomeController()){
    _con = controller;
  }

  @override
  void didPopNext(){
    print("visible");
    super.didPopNext();
    // _con.getExpenses6Months(context);
    print("Notifying pop");
    settingsRepo.action = false;
    settingsRepo.invertColor = false;
    settingsRepo.large = false;
    settingsRepo.detail = true;
    ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshHome);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settingsRepo.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose(){
    settingsRepo.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _con.getClusters();
    settingsRepo.action = false;
    settingsRepo.invertColor = false;
    settingsRepo.large = false;
    settingsRepo.detail = true;
    ExpenseBloc.expEventStream.listen((event)async{
      if(event == ExpenseEvent.RefreshHome) {
        await _con.getClusters();
        await _con.getExpenses6Months(context);
      }
      // ExpenseBloc.mapexpEventToState(event);
    });
    _con.getExpenses6Months(context);
    _con.getExpensesTimeSpane(context);

    // _con.getExpensesMonth(context, 2, 2021);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              height: MediaQuery.of(context).size.height * 0.1 + 20,
              width: MediaQuery.of(context).size.width,
              // color: grey,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed('/Account');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        // decoration: BoxDecoration(border: testBorder),
                        child: Image.asset(
                          'assets/img/profile.png',
                          width: MediaQuery.of(context).size.width * 0.1,
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
                              // months[_con.currentMonth] + "'s Expenses",
                              _con.dataBarGraph.isNotEmpty ? months[_con.currentMonth-1] + "'s Expenses" : "No Expenses",
                              style: font.merge(
                                  TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      color: accentColor.withOpacity(0.6)
                                  )
                              ),
                            )
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.008,
                        ),
                        Visibility(
                          visible: _con.dataBarGraph.isNotEmpty,
                          child: Container(
                              child: Text(
                                "₹ " + (_con.rawData.isNotEmpty ? _con.rawData[rawDataIndex].barRods[0].y.toInt().toString() : ""),
                                style: font.merge(
                                    TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.065,
                                        color: accentColor,
                                      letterSpacing: amountspacing
                                    )
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: accentColor
                ),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Visibility(
                          visible: true,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: borderRadius20,
                                    color: primaryColor
                                ),
                                // margin: EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: BarChart(
                                  BarChartData(
                                    maxY: (_con.maxValue + 2000).toDouble(),
                                    barGroups: _con.rawData,
                                    titlesData:FlTitlesData(
                                        bottomTitles:SideTitles(
                                            showTitles: true,
                                            getTextStyles: (value) {
                                              return TextStyle(
                                                  color: accentColor,
                                                  fontSize: 14,
                                                  letterSpacing: 1.1
                                              );
                                            },
                                            getTitles:(double values){
                                              switch(values.toInt()){
                                                case 1:
                                                  return "Jan";
                                                case 2:
                                                  return "Feb";
                                                case 3:
                                                  return "Mar";
                                                case 4:
                                                  return "Apr";
                                                case 5:
                                                  return "May";
                                                case 6:
                                                  return "Jun";
                                                case 7:
                                                  return "Jul";
                                                case 8:
                                                  return "Aug";
                                                case 9:
                                                  return "Sep";
                                                case 10:
                                                  return "Oct";
                                                case 11:
                                                  return "Nov";
                                                case 12:
                                                  return "Dec";
                                              }
                                              return "Err";
                                            }
                                        ),
                                        leftTitles: SideTitles(
                                            showTitles: false
                                        )
                                    ),
                                    borderData: FlBorderData(
                                        show: false
                                    ),
                                    barTouchData: BarTouchData(
                                      enabled: true,
                                      touchExtraThreshold: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      touchCallback: (response){
                                        print(response.spot);
                                        if(response.spot!=null){
                                          print(response.spot.touchedBarGroup.x.toString());
                                          _con.currentMonth = response.spot.touchedBarGroup.x;
                                          rawDataIndex = response.spot.touchedBarGroupIndex;
                                          _con.currentYear = _con.dataBarGraph[_con.currentMonth]['year'];
                                          print("CM: " + _con.currentMonth.toString() + ", CY: " + _con.currentYear.toString());
                                          print("RDI");
                                          print(rawDataIndex.toString());
                                          _con.makeDataSets(context);
                                        }
                                      },
                                      touchTooltipData: BarTouchTooltipData(
                                          tooltipRoundedRadius: 12,
                                          tooltipBgColor: accentColor.withOpacity(0.9),
                                          getTooltipItem: (bcgd, x, bcrd, y){
                                            return BarTooltipItem(
                                                bcrd.y.toString(),
                                                font.merge(
                                                    TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 16
                                                    )
                                                ),
                                            );
                                          },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/ExpensesPage', arguments: RouteArgument(param: {"month":_con.currentMonth, "year": _con.currentYear}));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      // decoration: BoxDecoration(border: testBorder),
                                      child: Text(
                                          "Expenses >>",
                                        style: font.merge(
                                          TextStyle(
                                            color: accentColor,
                                            letterSpacing: 1.1
                                          )
                                        ),
                                      )
                                  ),
                                ),
                              ),
                              // exRepo.expenses.isEmpty ? NoExpenses(textColor: primaryColor,) : Container(height: 0, width: 0,),
                            ],
                          ),
                        ),
                        _con.expenseList.isEmpty ? Container(child: NoExpenses(textColor: primaryColor, text: "No Expenses for last 7 days!",),margin: EdgeInsets.symmetric(vertical: 30),) : ExpenseBatchPage(con: _con,),
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}