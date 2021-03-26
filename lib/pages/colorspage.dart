import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class ColorsPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<ColorsPage>{
  String heading = 'Colors';
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
                child: BackbuttonAppBar(
                  heading: heading,
                  color: accentColor,
                  tag: "Changes will take effect from Home Page",
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: accentColor
                ),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20
                  ),
                  itemCount: primaryColors.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        settingsRepo.saveColorIndex(index);
                        setState(() {

                        });
                      },
                      child: Container(
                        // width: MediaQuery.of(context).s,
                        decoration: BoxDecoration(
                          color: primaryColors[index],
                          borderRadius: borderRadius20
                        ),
                        child: Visibility(
                          visible: settingsRepo.colorIndex == index,
                          child: Icon(
                            Icons.done,
                            color: accentColor,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ),
            )
          ],
        ),
      )
    );
  }
}