import 'package:expensemanager/helpers/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class DataModel{
  int x;
  double y;
  DataModel({this.x, this.y});

  BarChartGroupData getBarChartGroupData(width, currentMonth, zero){
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: zero ? x == currentMonth ? [] : [] : [],
      barRods: [
        BarChartRodData(
          y: y,
          colors: [x==currentMonth ? barColor : secondColor],
          width: width,
        ),
      ]
    );
  }
}