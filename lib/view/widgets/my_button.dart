import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.name,
    this.height = 52,
    this.width = double.infinity,
    this.color = Colors.blue,
    required this.onPressed,
    this.textColor,
    this.fontSize,
  });

  final String name;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color color;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
            color: textColor, fontSize: fontSize, fontWeight: FontWeight.w700),
      ),
    );
  }
}
