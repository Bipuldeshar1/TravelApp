import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/bookingModel.dart';
import 'package:project_3/reusableComponent/CustomButton.dart';
import 'package:project_3/reusableComponent/customCard.dart';
import 'package:project_3/reusableComponent/customcardorder.dart';
import 'package:project_3/reusableComponent/des.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';

import '../../model/packagemodel.dart';

class DashboardOrder extends StatefulWidget {
  @override
  State<DashboardOrder> createState() => _DashboardOrderState();
}

class _DashboardOrderState extends State<DashboardOrder> {
  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.email;

    Future<List<Booking>> fetchOrder() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('sEmail', isEqualTo: id)
          .get();
      final userData =
          snapshot.docs.map((x) => Booking.fromJson(x.data())).toList();
      return userData;
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('orders'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: fetchOrder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final package = snapshot.data![index];
                  return CustomCardorders(
                      img: package.pImg,
                      price: package.price.toString(),
                      title: package.pTitle,
                      cname: package.uName,
                      pnum: package.pnum);
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
