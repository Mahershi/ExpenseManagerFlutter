import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// INT
int home = 1;
int expense = 2;
int spend = 0;
int profile = 3;

double amountspacing = 1.1;

// DESIGN
Border testBorder = Border.all(color: Colors.red);

BorderRadius borderRadius12 = BorderRadius.circular(12);
BorderRadius borderRadius20 = BorderRadius.circular(20);
BorderRadius borderRadius30 = BorderRadius.circular(30);
Radius radius12 = Radius.circular(12);
Radius radius20 = Radius.circular(20);
Radius radius30 = Radius.circular(30);

TextStyle font = GoogleFonts.comfortaa();

List<Color> primaryColors = [
  Color(0xFF348275),
  Color(0xFF2D303E),
  Color(0xFF7484FE),
];

List<Color> secondColors = [
  Color(0xFF70A79E),
  Color(0xFF6c6e77),
  Color(0xFF9da8fe)
];

List<Color> accentColors = [
  Colors.white,
  Colors.white,
  Colors.white

];

List<Color> barColors = [
  Color(0xFFEF8767),
  Color(0xFFEF8767),
  Colors.white
];

// COLORS
Color primaryColor = Color(0xFF348275);
Color secondColor = Color(0xFF759D7A);
Color accentColor = Colors.white;
Color red = Colors.red;
Color black = Colors.black;
Color grey = Colors.grey;
Color orange = Colors.orangeAccent;
Color yellow = Colors.yellowAccent;
Color barColor = Color(0xFFEF8767);

// MONTHS
List<String> weekDay = ['', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];


List<Color> colorsForPie = [Colors.red, Colors.blue, Colors.teal, Colors.purple, Colors.orangeAccent, Colors.pinkAccent, Colors.deepPurple, Colors.lightGreen, Colors.brown];
//FONT SIZE

double splashHeading(context){
  return MediaQuery.of(context).size.width * 0.07;
}