import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/screens/Home/home.dart';
import 'package:project_3/screens/auth/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FirebaseAuth.instance.currentUser != null
              ? HomeScreen()
              : Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff329cef),
      // body: Center(
      //   child: Image.asset(
      //     "assets/dart.png",
      //     width: double.infinity,
      //     height: double.infinity,
      //   ),
      // ),
    );
  }
}
