import 'package:expensemanager/helpers/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class DataModel{
  int x;
  double y;
  DataModel({this.x, this.y});

  BarChartGroupData getBarChartGroupData(width, currentMonth){
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: x == currentMonth ? [0] : [],
      barRods: [
        BarChartRodData(
          y: y,
          colors: [x==currentMonth ? pinkShade : secondColor],
          width: width,
        ),
      ]
    );
  }
}