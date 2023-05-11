import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';
import 'package:project_3/screens/Home/home.dart';
import 'package:project_3/screens/Home/nav.dart';
import 'package:project_3/screens/splashscreen/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: (FirebaseAuth.instance.currentUser != null) ? HomeScreen() : Login());
      home: SplashScreen(),
    );
  }
}
