import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// INT
int home = 1;
int expense = 2;
int spend = 0;
int profile = 3;

// DESIGN
Border testBorder = Border.all(color: Colors.red);

BorderRadius borderRadius12 = BorderRadius.circular(12);
BorderRadius borderRadius20 = BorderRadius.circular(20);
BorderRadius borderRadius30 = BorderRadius.circular(30);
Radius radius12 = Radius.circular(12);
Radius radius20 = Radius.circular(20);
Radius radius30 = Radius.circular(30);

TextStyle font = GoogleFonts.comfortaa();

// COLORS
const Color primaryColor = Color(0xFF348275);
Color secondColor = Color(0xFF759D7A);
Color white = Colors.white;
Color red = Colors.red;
Color black = Colors.black;
Color grey = Colors.grey;
Color orange = Colors.orangeAccent;
Color yellow = Colors.yellowAccent;
Color pinkShade = Color(0xFFEF8767);

// MONTHS

List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

//FONT SIZE

double splashHeading(context){
  return MediaQuery.of(context).size.width * 0.07;
}