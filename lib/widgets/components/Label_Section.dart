import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';
import 'package:project_3/screens/Home/seeAll.dart';

class LabelSection extends StatelessWidget {
  final String text;

  final TextStyle style;

  const LabelSection({
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: style,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SeeAllScreen())));
            },
            child: Text(
              'see All',
            ),
          ),
        ],
      ),
    );
  }
}
