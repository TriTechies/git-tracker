import 'package:flutter/material.dart';

TextStyle defaultstyle({required String fontFamily, required double size, required Color color,double height=1.1}) {
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: FontWeight.bold,
      height: height,
      color: color);
}

TextStyle secondDefault({required String fontFamily, required double size, required Color color, TextOverflow overflow = TextOverflow.visible,double height=1.1}) {
  return TextStyle(fontFamily: fontFamily, fontSize: size, color: color,   overflow: overflow,height: height );
}

TextStyle withoutFontWeight({required String fontFamily, required double size, required Color color}) {
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      color: color,
      fontWeight: FontWeight.normal);
}   


TextStyle fontWeightStyle({required String fontFamily, required double size, required Color color, required FontWeight weight}) {
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      color: color,
      fontWeight: weight);
}   