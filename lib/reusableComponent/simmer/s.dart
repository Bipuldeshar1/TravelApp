
import 'package:flutter/material.dart';
import 'package:project_3/reusableComponent/simmer/skeleton.dart';

class s extends StatelessWidget {
  const s({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skeleton(height: 120, width: 120),
        Expanded(
            child: Column(
          children: [
            Skeleton(width: 80),
            const SizedBox(
              height: 8,
            ),
            Skeleton(),
            const SizedBox(
              height: 8,
            ),
            Skeleton(),
            const SizedBox(
              height: 8,
            )
          ],
        ))
      ],
    );
  }
}
