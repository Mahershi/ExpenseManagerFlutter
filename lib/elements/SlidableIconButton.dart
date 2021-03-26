import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableIconButton extends StatelessWidget{
  IconData myIcon;
  double iconSize;

  SlidableIconButton({this.myIcon, this.iconSize});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10,),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(topRight: radius20, bottomRight: radius20),
            borderRadius: borderRadius20,
            color: white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              myIcon,
              color: black,
              size: iconSize,
            ),
          ],
        )

    );
  }
}