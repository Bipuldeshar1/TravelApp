import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final int? ratingCount;

  const RatingBar({super.key, 
    required this.rating,
    this.ratingCount,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(const Icon(
          Icons.star,
          color: Color.fromARGB(255, 250, 225, 0),
        ));
      } else if (i == realNumber && partNumber > 0) {
        starList.add(const Icon(
          Icons.star_half,
          color: Color.fromARGB(255, 250, 225, 0),
        ));
      } else {
        starList.add(Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starList,
    );
  }
}
