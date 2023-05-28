import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/bookingModel.dart';
import 'package:project_3/reusableComponent/card/notificationCard.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Stream<List<Booking>> fetch() {
      final snapshot = FirebaseFirestore.instance
          .collection('notification')
          .where('uId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      var userData = snapshot.then((snapshot) =>
          snapshot.docs.map((e) => Booking.fromJson(e.data())).toList());

      return Stream.fromFuture(userData);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: StreamBuilder(
        stream: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final package = snapshot.data![index];
                  return NotificationCard(
                      msg: package.msg,
                      title: package.pTitle,
                      name: package.uName);
                });
          } else if (snapshot.hasError) {
            return Text("Error fetching data!");
          } else if (snapshot.data == null) {
            return Text('no data');
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
