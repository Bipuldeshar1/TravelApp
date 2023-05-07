import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';
import 'package:project_3/screens/Admin/order.dart';
import 'package:project_3/screens/Admin/product.dart';
import 'package:project_3/screens/auth/login.dart';

class AdminHomescreen extends StatefulWidget {
  AdminHomescreen({Key? key}) : super(key: key);

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('home'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      ),
    );
  }
}
