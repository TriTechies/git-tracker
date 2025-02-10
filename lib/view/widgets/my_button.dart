import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.name,
      required this.height,
      required this.width,
      required this.color,
      required this.route,
      this.textColor,
      this.fontsize});

  final String name;
  final VoidCallback route;
  final double height;
  final double width;
  final Color color;
  final Color? textColor;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: route,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          minimumSize: Size(width, height),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
              
      child: Text(
        name,
       
          textAlign: TextAlign.start,
        style: TextStyle(
            color: textColor, fontSize: fontsize, fontWeight: FontWeight.w700),
      ),
    );
  }
}