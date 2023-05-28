import 'package:flutter/material.dart';

import 'package:project_3/screens/Home/home.dart';

class SoloPost extends StatefulWidget {
  SoloPost({Key? key}) : super(key: key);

  @override
  State<SoloPost> createState() => _SoloPostState();
}

//only here
class _SoloPostState extends State<SoloPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('posts'),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
