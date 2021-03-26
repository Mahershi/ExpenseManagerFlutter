import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/material.dart';

class CurvyRightTop extends CustomPainter{
  Color myColor;
  CurvyRightTop({this.myColor});
  @override
  void paint(Canvas canvas, Size size) {
    print(size.toString());
    final paint = Paint()
      ..color = myColor.withOpacity(1)
      ..style = PaintingStyle.fill;

    final path = new Path();
    path.moveTo(size.width * 0.58, 0);
    path.cubicTo(size.width * 0.7, size.width * 0.2, size.width * 0.7, size.width*0.3, size.width, size.width*0.4);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}