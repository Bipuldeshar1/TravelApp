import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';

class LabelSection extends StatelessWidget {
  final String text;
  final TextStyle style;
  const LabelSection({required this.text, required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: style,
        ),
        Icon(
          Icons.more_horiz,
          color: icon,
          size: 28,
        )
      ],
    );
  }
}
