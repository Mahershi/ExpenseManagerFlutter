import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/DataSet.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<HomePage> with WidgetsBindingObserver{
  List<BarChartGroupData> rawData = List<BarChartGroupData>();
  int currentMonth = 6;
  int rawDataIndex = 3;

  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      makeDataSets();
    });
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
                          color: white,
                        )
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                            child: Text(
                              months[currentMonth] + "'s Expenses",
                              style: font.merge(
                                  TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      color: white.withOpacity(0.6)
                                  )
                              ),
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Text(
                              "₹ " + (rawData.isNotEmpty ? rawData[rawDataIndex].barRods[0].y.toString() : ""),
                              style: font.merge(
                                  TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.065,
                                      color: white
                                  )
                              ),
                            )
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
                    color: white
                ),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
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
                                  maxY: 9000,
                                  barGroups: rawData,
                                  titlesData:FlTitlesData(
                                      bottomTitles:SideTitles(
                                          showTitles: true,
                                          getTextStyles: (value) {
                                            return TextStyle(
                                                color: white,
                                                fontSize: 14,
                                                letterSpacing: 1.1
                                            );
                                          },
                                          getTitles:(double values){
                                            switch(values.toInt()){
                                              case 0:
                                                return "Jan";
                                              case 1:
                                                return "Feb";
                                              case 2:
                                                return "Mar";
                                              case 3:
                                                return "Apr";
                                              case 4:
                                                return "May";
                                              case 5:
                                                return "Jun";
                                              case 6:
                                                return "Jul";
                                              case 7:
                                                return "Aug";
                                              case 8:
                                                return "Sep";
                                              case 9:
                                                return "Oct";
                                              case 10:
                                                return "Nov";
                                              case 11:
                                                return "Dec";

                                            }
                                            return "A";
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
                                    touchCallback: (response){
                                      if(response.spot!=null){
                                        print(response.spot.touchedBarGroup.x.toString());
                                        currentMonth = response.spot.touchedBarGroup.x;
                                        rawDataIndex = response.spot.touchedBarGroupIndex;
                                        makeDataSets();
                                      }
                                    },
                                    touchTooltipData: BarTouchTooltipData(
                                        tooltipRoundedRadius: 12,
                                        tooltipBgColor: white.withOpacity(0.9),
                                        getTooltipItem: (bcgd, x, bcrd, y){
                                          return BarTooltipItem(
                                              bcrd.y.toString(),
                                              font.merge(
                                                  TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 16
                                                  )
                                              )
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
                                  Navigator.of(context).pushNamed('/ExpensesPage', arguments: RouteArgument(param: currentMonth));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    // decoration: BoxDecoration(border: testBorder),
                                    child: Text(
                                        "Details >>",
                                      style: font.merge(
                                        TextStyle(
                                          color: white
                                        )
                                      ),
                                    )
                                ),
                              ),
                            )
                          ],
                        )
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

  void makeDataSets(){
    rawData = List<BarChartGroupData>();
    rawData.add(DataModel(x: 3, y: 5000).getBarChartGroupData(MediaQuery.of(context).size.width/10, currentMonth));
    rawData.add(DataModel(x: 4, y: 4300).getBarChartGroupData(MediaQuery.of(context).size.width/10, currentMonth));
    rawData.add(DataModel(x: 5, y: 6788).getBarChartGroupData(MediaQuery.of(context).size.width/10, currentMonth));
    rawData.add(DataModel(x: 6, y: 7000).getBarChartGroupData(MediaQuery.of(context).size.width/10, currentMonth));
    rawData.add(DataModel(x: 7, y: 3000).getBarChartGroupData(MediaQuery.of(context).size.width/10, currentMonth));
    rawData.add(DataModel(x: 8, y: 7000).getBarChartGroupData(MediaQuery.of(context).size.width/10, currentMonth));
    setState(() {

    });
  }
}