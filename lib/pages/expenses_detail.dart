import 'package:carousel_slider/carousel_slider.dart';
import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/elements/expense_item.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesDetail extends StatefulWidget{
  RouteArgument routeArgument;

  ExpensesDetail({this.routeArgument});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ExpensesDetail>{
  CarouselController controller = CarouselController();
  int currentMonth = 0;
  String heading = "Expenses";

  @override
  void initState(){
    super.initState();
    currentMonth = widget.routeArgument.param;
    print(currentMonth.toString());
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
                              child: CarouselSlider(
                                carouselController: controller,
                                options: CarouselOptions(
                                  initialPage: currentMonth,
                                  enableInfiniteScroll: false,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  viewportFraction: 0.27,
                                  onPageChanged: (x, reason){
                                    print(controller.ready);
                                    print(x.toString());
                                    print(reason.toString());
                                    currentMonth = x;
                                    setState(() {

                                    });
                                  }
                                ),
                                items: months.map((e){
                                  return InkWell(
                                    onTap: (){
                                      currentMonth = months.indexOf(e);
                                      controller.animateToPage(currentMonth);
                                    },
                                    child: Container(
                                      // decoration: BoxDecoration(border: testBorder),
                                      alignment: Alignment.center,
                                      child: Text(
                                        e.substring(0, 3),
                                        style: font.merge(
                                          TextStyle(
                                            color: months.indexOf(e) == currentMonth ? white : secondColor,
                                            letterSpacing: 1.3
                                          )
                                        ),
                                      )
                                    ),
                                  );
                                }).toList(),
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
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
                            ExpenseItem(myIcon: Icons.home, text: "Food", value: 300,),
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