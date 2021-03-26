import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expensemanager/controllers/expensedetail_controller.dart';
import 'package:expensemanager/elements/add_expense_dialog.dart';
import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/elements/expense_item.dart';
import 'package:expensemanager/elements/expense_list_main.dart';
import 'package:expensemanager/elements/no_expenses.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:expensemanager/pages/expense_batch_page.dart';
import 'package:expensemanager/repositories/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;
import 'package:expensemanager/blocs/expense_detail_bloc.dart';
class ExpensesDetail extends StatefulWidget{
  RouteArgument routeArgument;

  ExpensesDetail({this.routeArgument});
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<ExpensesDetail> with RouteAware{
  ExpenseDetailController _con;
  CarouselController carouselController = CarouselController();
  CarouselController carouselController2 = CarouselController();

  int currentMonth = 0;
  String heading = "Expenses";
  int currentYear = 1;
  int yearIndex = DateTime.now().year;

  PageState() : super(ExpenseDetailController()){
    _con = controller;
    ExpenseBloc.controller = _con;
  }

  @override
  void initState(){
    super.initState();

    ExpenseBloc.expEventStream.listen((event)async{
      if(event == ExpenseEvent.RefreshExpenseDetail)
        await _con.getExpensesMonth(context, currentMonth+1, currentYear);
      // ExpenseBloc.mapexpEventToState(event);
    });
    print(widget.routeArgument.param.toString());
    currentMonth = widget.routeArgument.param['month'] - 1;
    currentYear = widget.routeArgument.param['year'];
    yearIndex = _con.yearLocal.indexOf(currentYear.toString());

    print("CM: " +currentMonth.toString());
    print("CY: " + currentYear.toString());
    _con.getExpensesMonth(context, currentMonth+1, currentYear);
  }

  @override
  void didPopNext(){

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
  Widget build(BuildContext context){
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
                // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      margin: EdgeInsets.only(left: 40, right: 20, top: 40, bottom: 10),
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
                                      "₹ " + _con.total.toString(),
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
                                          initialPage: yearIndex,
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
                                            setState(() {_con.isLoading = true;});
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

                                            setState(() {_con.isLoading = true;});
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
                        child:  _con.isLoading ? Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(white),
                                strokeWidth: 2,
                              )
                          ),
                        ) : _con.expenseList.isNotEmpty ? ExpenseList(con: _con,) : Container(
                          child: NoExpenses(textColor: white,),
                          alignment: Alignment.center,
                        ),
                    )
                  ],
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
                      ExpenseModel e = ExpenseModel.createFor(currentMonth+1, currentYear);
                      // e.id = null;
                      // e.cluster_id = '0';
                      // e.category_id = '1';
                      // e.name = '';
                      // e.amount = '0';
                      // DateTime time = DateTime.now();
                      // e.expense_date = DateTime(currentYear, currentMonth+1, DateTime.now().day, time.hour, time.minute, time.second).toString();
                      // e.user_id = currentUser.id;
                      return AddExpenseDialog(expense: e, title: "Add Expense",);
                    },
                  ).then((value){
                    print("visible");
                    if(value == null)
                      value = false;
                    if (value)
                      _con.getExpensesMonth(context, currentMonth+1, currentYear);
                  });
                },
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
              ),
            )
          ],
        ),
      ),
    );
  }
}