import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expensemanager/controllers/expensedetail_controller.dart';
import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/elements/expense_item.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;

class ExpensesDetail extends StatefulWidget{
  RouteArgument routeArgument;

  ExpensesDetail({this.routeArgument});
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<ExpensesDetail>{
  ExpenseDetailController _con;
  CarouselController carouselController = CarouselController();
  CarouselController carouselController2 = CarouselController();

  int currentMonth = 0;
  String heading = "Expenses";
  int currentYear = 1;
  int yearIndex = DateTime.now().year;

  PageState() : super(ExpenseDetailController()){
    _con = controller;
  }

  @override
  void initState(){
    super.initState();

    print(widget.routeArgument.param.toString());
    currentMonth = widget.routeArgument.param['month'] - 1;
    yearIndex = _con.yearLocal.indexOf(exRepo.latest_year.toString());
    currentYear = widget.routeArgument.param['year'];
    print("CM@: " +currentMonth.toString());
    _con.getExpensesMonth(context, currentMonth+1, currentYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: white,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.1 + 20,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BackbuttonAppBar(
                heading: heading,
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: primaryColor
                ),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Total",
                                  style: font.merge(
                                    TextStyle(
                                      color: white,
                                      fontSize: MediaQuery.of(context).size.width * 0.055,
                                    )
                                  )
                                )
                              ),
                              SizedBox(height: 5,),
                              Container(
                                  child: Text(
                                      "₹ 8000",
                                      style: font.merge(
                                          TextStyle(
                                            color: white,
                                            fontSize: MediaQuery.of(context).size.width * 0.09,
                                          )
                                      )
                                  )
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              // decoration: BoxDecoration(border: testBorder),
                              child: Column(
                                children: [
                                  CarouselSlider(
                                    carouselController: carouselController2,
                                    options: CarouselOptions(
                                        initialPage: currentYear,
                                        enableInfiniteScroll: false,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        viewportFraction: 0.27,
                                        onPageChanged: (x, reason){
                                          yearIndex = x;
                                          currentYear = int.parse(_con.yearLocal[yearIndex]);
                                          print("cy: " + currentYear.toString());

                                          if(reason == CarouselPageChangedReason.manual){
                                            _con.timer.cancel();
                                            _con.timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
                                              _con.getExpensesMonth(context, currentMonth+1, currentYear);
                                              _con.timer.cancel();
                                            });
                                          }else{
                                            _con.getExpensesMonth(context, currentMonth+1, currentYear);
                                          }

                                          setState(() {});
                                        }
                                    ),
                                    items: _con.yearLocal.map((e){
                                      return InkWell(
                                        onTap: (){
                                          currentYear = _con.yearLocal.indexOf(e);
                                          // print("cy: " + currentYear.toString());
                                          carouselController2.animateToPage(currentYear);
                                        },
                                        child: Visibility(
                                          visible: e == "None" ? false : true,
                                          child: Container(
                                            // decoration: BoxDecoration(border: testBorder),
                                              alignment: Alignment.center,
                                              child: Text(
                                                e,
                                                style: font.merge(
                                                    TextStyle(
                                                        color: _con.yearLocal.indexOf(e) == yearIndex ? white : secondColor,
                                                        letterSpacing: 1.3
                                                    )
                                                ),
                                              )
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  CarouselSlider(
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      initialPage: currentMonth,
                                      enableInfiniteScroll: false,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      viewportFraction: 0.27,
                                      onPageChanged: (x, reason){
                                        currentMonth = x;
                                        print(reason.toString());
                                        print("CM:" + currentMonth.toString());
                                        if(reason == CarouselPageChangedReason.manual){
                                          _con.timer.cancel();
                                          _con.timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
                                            _con.getExpensesMonth(context, currentMonth+1, currentYear);
                                            _con.timer.cancel();
                                          });
                                        }else{
                                          _con.getExpensesMonth(context, currentMonth+1, currentYear);
                                        }

                                        setState(() {});
                                      }
                                    ),
                                    items: (yearIndex == _con.yearLocal.length-1 ? _con.monthsLocal : months).map((e){
                                      return InkWell(
                                        onTap: (){
                                          currentMonth = (yearIndex == _con.yearLocal.length-1 ? _con.monthsLocal : months).indexOf(e);
                                          carouselController.animateToPage(currentMonth);
                                          // print("CM:" + currentMonth.toString());
                                        },
                                        child: Visibility(
                                          visible: e == "None" ? false : true,
                                          child: Container(
                                            // decoration: BoxDecoration(border: testBorder),
                                            alignment: Alignment.center,
                                            child: Text(
                                              e.substring(0, 3),
                                              style: font.merge(
                                                TextStyle(
                                                  color: (yearIndex == _con.yearLocal.length-1 ? _con.monthsLocal : months).indexOf(e) == currentMonth ? white : secondColor,
                                                  letterSpacing: 1.3
                                                )
                                              ),
                                            )
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width * 0.22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white
                ),
                child: Icon(
                  Icons.add,
                  size: MediaQuery.of(context).size.width * 0.08,
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}