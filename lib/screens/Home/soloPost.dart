import 'package:flutter/material.dart';

class SoloPost extends StatefulWidget {
  const SoloPost({super.key});

  @override
  State<SoloPost> createState() => _SoloPostState();
}

class _SoloPostState extends State<SoloPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('msg'),
      ),
    );
  }
}
