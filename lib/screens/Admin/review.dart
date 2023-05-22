import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/reviewmodel.dart';

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
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(children: [
                        Text('review :\n ${package.review}'),
                        Text('reviewed by\n${package.sName}'),
                        Text('reviewed on\n${package.title}')
                      ]),
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
