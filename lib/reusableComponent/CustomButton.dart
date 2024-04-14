import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final onPress;
  double width;
  double height;
  CustomButton({super.key, 
    required this.text,
    required this.onPress,
    required this.color,
    required this.height,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
