import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';


import '../auth/login.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login())));
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                var x = Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminHomescreen()));
                var y = Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
                FirebaseAuth.instance.currentUser != null ? x : y;
              },
              child: Text('a'))
        ],
      ),
    );
  }
}
