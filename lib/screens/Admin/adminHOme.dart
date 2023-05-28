import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';

import 'package:project_3/screens/auth/login.dart';

class AdminHomescreen extends StatefulWidget {
  AdminHomescreen({Key? key}) : super(key: key);

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {
  @override
  Widget build(BuildContext context) {
    Future<int> getproduct() async {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('Allposts')
              .where('uId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();
      final int numberOfProducts = snapshot.size;
      return numberOfProducts;
    }

    Future<int> getPorder() async {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('orders')
              .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();
      final int numberOfProducts = snapshot.size;
      return numberOfProducts;
    }

    Future<int> getreview() async {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('reviews')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();
      final int numberOfProducts = snapshot.size;
      return numberOfProducts;
    }

    Future<int> getCorder() async {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('CBooking')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();
      final int numberOfProducts = snapshot.size;
      return numberOfProducts;
    }

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('home'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login())));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: getproduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('products ${snapshot.data.toString()}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder(
              future: getPorder(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('orders ${snapshot.data.toString()}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder(
              future: getreview(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('reviews${snapshot.data.toString()}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder(
              future: getCorder(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('cOrder${snapshot.data.toString()}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ));
  }
}
