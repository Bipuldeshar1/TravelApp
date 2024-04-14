import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/bookingModel.dart';
import 'package:project_3/reusableComponent/customCardfav.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';

class PendingBooking extends StatefulWidget {
  const PendingBooking({Key? key}) : super(key: key);

  @override
  State<PendingBooking> createState() => _PendingBookingState();
}

class _PendingBookingState extends State<PendingBooking> {
  Future<List<Booking>> fetch() async {
    var document = await FirebaseFirestore.instance
        .collection('orders')
        .where('uEmail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    final userData = document.docs
        .map((doc) => Booking.fromJson(doc.data()))
        .toList(); // map each document to a Booking object
    return userData;
  }

  Future<void> deletePackage(String packageId) async {
    // Delete the package from Firestore
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(packageId)
        .delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Booking>>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final packages = snapshot.data!;
              return SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    final package = packages[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomCardFav(
                          img: package.pImg,
                          price: package.price.toString(),
                          title: package.pTitle,
                          onpresss: () {
                            deletePackage(package.id);
                          }),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("Error fetching data!");
            } else {
              return SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return const s();
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
