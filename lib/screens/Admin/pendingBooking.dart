import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/bookingModel.dart';
import 'package:project_3/reusableComponent/customcardorder.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';

class PendingBooking extends StatefulWidget {
  const PendingBooking({super.key});

  @override
  State<PendingBooking> createState() => _PendingBookingState();
}

class _PendingBookingState extends State<PendingBooking> {
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.email;

    Stream<List<Booking>> fetchOrder() {
      final snapshot = FirebaseFirestore.instance
          .collection('orders')
          .where('sEmail', isEqualTo: id)
          .get();
      final userData = snapshot.then((snapshot) =>
          snapshot.docs.map((x) => Booking.fromJson(x.data())).toList());
      return Stream.fromFuture(userData);
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('orders'),
      ),
      body: StreamBuilder<List<Booking>>(
        stream: fetchOrder(),
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
                    pnum: package.pnum,
                    email: package.sEmail,
                    onpresss: () {
                      myDialog(package);
                    },
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

  void myDialog(Booking package) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 200,
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('CBooking')
                          .doc(package.id)
                          .set({
                            'id': package.id,
                            'bookingDate': package.bookingDate,
                            'pId': package.pId,
                            'pdescription': package.pDescription,
                            'pimg': package.pImg,
                            'pnum': package.pnum,
                            'price': package.price,
                            'ptitle': package.pTitle,
                            'sEmail': package.sEmail,
                            'sid': package.sId,
                            'uId': package.uId,
                            'uName': package.uName
                          })
                          .then((value) => storenotification(package))
                          .then((value) => del(package));
                    },
                    icon: Icon(Icons.confirmation_num_rounded),
                    label: Text('confirm'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      var date = DateTime.now();
                      String msg = 'Booking Rejected ';
                      try {
                        FirebaseFirestore.instance
                            .collection('notification')
                            .doc(package.id)
                            .set({
                          'id': package.id,
                          'msg': msg,
                          'nDate': date,
                          'bookingDate': package.bookingDate,
                          'pId': package.pId,
                          'pdescription': package.pDescription,
                          'pimg': package.pImg,
                          'pnum': package.pnum,
                          'price': package.price,
                          'ptitle': package.pTitle,
                          'sEmail': package.sEmail,
                          'sid': package.sId,
                          'uId': package.uId,
                          'uName': package.uName
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                      del(package);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('reject booking'),
                  )
                ],
              ),
            ),
          );
        });
  }

  storenotification(Booking package) {
    String msg = 'Booking confirmed';
    var date = DateTime.now();
    try {
      FirebaseFirestore.instance
          .collection('notification')
          .doc(package.pId)
          .set({
        'id': package.id,
        'msg': msg,
        'nDate': date,
        'bookingDate': package.bookingDate,
        'pId': package.pId,
        'pdescription': package.pDescription,
        'pimg': package.pImg,
        'pnum': package.pnum,
        'price': package.price,
        'ptitle': package.pTitle,
        'sEmail': package.sEmail,
        'sid': package.sId,
        'uId': package.uId,
        'uName': package.uName
      });
    } catch (e) {
      print(e.toString());
    }
  }

  del(Booking package) {
    try {
      FirebaseFirestore.instance
          .collection('orders')
          .doc(package.id)
          .delete()
          .then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PendingBooking())));
    } catch (e) {
      print(e);
    }
  }
}
