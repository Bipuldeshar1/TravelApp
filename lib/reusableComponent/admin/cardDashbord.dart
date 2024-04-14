import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  String title;
  String content;
  Icon icon;
  CardDashboard({super.key, 
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            spreadRadius: 2, // Shadow spread radius
            blurRadius: 5, // Shadow blur radius
            offset: const Offset(0, 3), // Shadow offset
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            height: 20,
          ),
          Text(title),
          const SizedBox(
            height: 20,
          ),
          Text(content),
        ],
      ),
    );
  }
}
