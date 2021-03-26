import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorSetting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/Colors');
      },
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: borderRadius30
          ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Theme Color",
              style: font.merge(
                TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05
                )
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.08,
                  width: MediaQuery.of(context).size.width * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius12,
                    color: primaryColor
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     margin: EdgeInsets.only(bottom: 5),
                //     height: MediaQuery.of(context).size.width * 0.03,
                //     width: MediaQuery.of(context).size.width * 0.03,
                //     decoration: BoxDecoration(
                //         // borderRadius: borderRadius12,
                //         color: accentColor
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        )
      ),
    );
  }
}