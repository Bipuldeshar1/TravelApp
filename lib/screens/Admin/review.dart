import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';
import 'package:project_3/model/reviewmodel.dart';

import 'package:project_3/screens/Admin/navdrawer.dart';

import '../../reusableComponent/simmer/s.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<ReviewModel>> fetch() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = snapshot.docs
          .map((doc) => ReviewModel.fromJson(doc.data()))
          .toList(); // map each document to a PackageModel object
      return userData;
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('reviews'),
      ),
      body: FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final package = snapshot.data![index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), // Shadow color
                            spreadRadius: 2, // Shadow spread radius
                            blurRadius: 5, // Shadow blur radius
                            offset: Offset(0, 3), // Shadow offset
                          )
                        ],
                      ),
                      height: 120,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                package.title,
                                style: heading2,
                              ),
                              const Text(
                                'review:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  package.review,
                                  style: p3,
                                ),
                              ),
                              const Text(
                                'reviewed by:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(package.uemail, style: p3),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("Error fetching data!");
          } else {
            return Container(
              height: double.infinity,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return s();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
