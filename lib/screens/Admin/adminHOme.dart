import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/reusableComponent/admin/cardDashbord.dart';
import 'package:project_3/reusableComponent/admin/carduser.dart';
import 'package:project_3/screens/Admin/Anotification.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';

import 'package:project_3/screens/auth/login.dart';

class AdminHomescreen extends StatefulWidget {
  const AdminHomescreen({Key? key}) : super(key: key);

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<PackageModel>> fetch() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('Allposts')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      final userData = snapshot.docs
          .map((doc) => PackageModel.fromJson(doc.data()))
          .toList(); // map each document to a PackageModel object
      return userData;
    }

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
              .where('sEmail',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .get();
      final int numberOfProducts = snapshot.size;
      return numberOfProducts;
    }

    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => Contact()));
            //     },
            //     icon: Icon(Icons.contact_emergency)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminNotificationScreen()));
                },
                icon: const Icon(Icons.notifications)),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Login())));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CardUser(
                    name: FirebaseAuth.instance.currentUser!.email.toString()),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureBuilder(
                            future: getproduct(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // return Text('products ${snapshot.data.toString()}');
                                return CardDashboard(
                                    title: 'products',
                                    content: snapshot.data.toString(),
                                    icon: const Icon(Icons
                                        .production_quantity_limits_rounded));
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          FutureBuilder(
                            future: getPorder(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // return Text('orders ${snapshot.data.toString()}');
                                return CardDashboard(
                                    title: 'Pending orders',
                                    content: snapshot.data.toString(),
                                    icon:
                                        const Icon(Icons.online_prediction_rounded));
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureBuilder(
                            future: getreview(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // return Text('reviews${snapshot.data.toString()}');
                                return CardDashboard(
                                    title: 'reviews',
                                    content: snapshot.data.toString(),
                                    icon: const Icon(
                                        Icons.dashboard_customize_outlined));
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          FutureBuilder(
                            future: getCorder(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // return Text('cOrder${snapshot.data.toString()}');
                                return CardDashboard(
                                    title: 'Confirmed orders',
                                    content: snapshot.data.toString(),
                                    icon:
                                        const Icon(Icons.production_quantity_limits));
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
