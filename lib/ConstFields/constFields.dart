import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var textInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.green,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);
MaterialColor Primery_color = Colors.green;

TextStyle HeadingStyle = GoogleFonts.roboto(
    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green);

TextStyle SubHeadingStyle = GoogleFonts.roboto(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey);

TextStyle SubTextStyle = GoogleFonts.roboto(color: Colors.grey);

TextStyle buttonText =
    GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold);

Color BgColor = Colors.green;
