import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/bookingModel.dart';
import 'package:project_3/reusableComponent/CustomcardHOme.dart';
import 'package:project_3/reusableComponent/customCard.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';

class PendingBooking extends StatefulWidget {
  const PendingBooking({super.key});

  @override
  State<PendingBooking> createState() => _PendingBookingState();
}

class _PendingBookingState extends State<PendingBooking> {
  @override
  Widget build(BuildContext context) {
    Future<List<Booking>> fetch() async {
      var document = await FirebaseFirestore.instance
          .collection('orders')
          .where('uEmail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      final userData = document.docs
          .map((doc) => Booking.fromJson(doc.data()))
          .toList(); // map eac
      return userData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: fetch(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 500,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final package = snapshot.data![index];
                        return CustomCardHome(
                          img: package.pImg,
                          price: package.price.toString(),
                          title: package.pTitle,
                          des: package.pDescription,
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text("Error fetching data!");
              } else {
                return Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return s();
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}
