import 'package:flutter/material.dart';

class CardUser extends StatelessWidget {
  String name;
  CardUser({super.key, 
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            spreadRadius: 2, // Shadow spread radius
            blurRadius: 5, // Shadow blur radius
            offset: const Offset(0, 3), // Shadow offset
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text('welcome to dashboard'),
                const SizedBox(
                  height: 5,
                ),
                Text(name),
              ],
            ),
          ),
          const Icon(
            Icons.flutter_dash,
            size: 40,
          ),
        ],
      ),
    );
  }
}
