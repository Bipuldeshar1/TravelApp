import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  int? ratingCount;
  RatingBar({
    required this.rating,
    this.ratingCount,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];

    int realnumber = rating.floor();
    int partNumber = ((rating - realnumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realnumber) {
        _starList.add(Icon(
          Icons.star,
          color: Color.fromARGB(255, 250, 225, 0),
        ));
      } else {
        _starList.add(Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}
