import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/pages/expenses_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<MainPage>{
  int currentPage = expense;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              child: currentPage == home
                  ? HomePage()
                  : currentPage == expense
                  ? ExpensesDetail()
                  : Container()
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: currentPage == home ? primaryColor : white,
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.04)
                ),
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          currentPage = spend;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_rounded,
                              color: currentPage == home ? white : primaryColor,
                              size: MediaQuery.of(context).size.width * 0.07,
                            )
                          ],
                        )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          currentPage = home;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_rounded,
                                color: currentPage == home ? white : primaryColor,
                                size: MediaQuery.of(context).size.width * 0.07,
                              )
                            ],
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          currentPage = expense;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_rounded,
                                color: currentPage == home ? white : primaryColor,
                                size: MediaQuery.of(context).size.width * 0.07,
                              )
                            ],
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          currentPage = profile;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle_rounded,
                                color: currentPage == home ? white : primaryColor,
                                size: MediaQuery.of(context).size.width * 0.07,
                              )
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}