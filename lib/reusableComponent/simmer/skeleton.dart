import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  double? width, height;
  Skeleton({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
      ),
    );
  }
}