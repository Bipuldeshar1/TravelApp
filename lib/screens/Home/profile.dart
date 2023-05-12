import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:project_3/screens/auth/login.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login())));
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
    );
  }
}
