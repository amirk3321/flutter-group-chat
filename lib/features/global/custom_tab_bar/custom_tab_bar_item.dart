



import 'package:flutter/material.dart';

class CustomTabBarItem extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final VoidCallback onTap;

  const CustomTabBarItem({
    Key? key,
    this.text="",
    this.width = 50.0,
    this.height = 50.0,
    this.borderColor = Colors.white,
    this.borderWidth = 3.0,
    this.textColor = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: borderColor, width: borderWidth))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
        ),
      ),
    );
  }
}