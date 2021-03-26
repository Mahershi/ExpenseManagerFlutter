import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableIconButton extends StatelessWidget{
  IconData myIcon;
  double iconSize;
  Color iconColor;
  Color bgColor;

  SlidableIconButton({this.myIcon, this.iconSize, this.iconColor, this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10,),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(topRight: radius20, bottomRight: radius20),
            borderRadius: borderRadius20,
            color: bgColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              myIcon,
              color: iconColor,
              size: iconSize,
            ),
          ],
        )

    );
  }
}