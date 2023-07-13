// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:project_3/model/bookingModel.dart';
// import 'package:project_3/reusableComponent/cardorder.dart';

// import 'package:project_3/reusableComponent/simmer/s.dart';
// import 'package:project_3/screens/Admin/navdrawer.dart';

// class ConfirmBooking extends StatefulWidget {
//   const ConfirmBooking({super.key});

//   @override
//   State<ConfirmBooking> createState() => _ConfirmBookingState();
// }

// class _ConfirmBookingState extends State<ConfirmBooking> {
//   @override
//   Widget build(BuildContext context) {
//     final id = FirebaseAuth.instance.currentUser!.uid;

//     Stream<List<Booking>> fetch() {
//       final snapshot = FirebaseFirestore.instance
//           .collection('CBooking')
//           .where('sid', isEqualTo: id)
//           .get();
//       final userData = snapshot.then((snapshot) =>
//           snapshot.docs.map((x) => Booking.fromJson(x.data())).toList());
//       return Stream.fromFuture(userData);
//     }

//     return Scaffold(
//       drawer: NavDrawer(),
//       appBar: AppBar(
//         title: Text('Confirm booking'),
//       ),
//       body: StreamBuilder(
//         stream: fetch(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final package = snapshot.data![index];
//                   // return CustomCardorders(
//                   //   img: package.pImg,
//                   //   price: package.price.toString(),
//                   //   title: package.pTitle,
//                   //   cname: package.uName,
//                   //   pnum: package.pnum,
//                   //   email: package.uEmail,
//                   //   onpresss: () {
//                   //     myDialog(package);
//                   //   },
//                   // );
//                   return OrderCard(
//                     onpresss: () {
//                       myDialog(package);
//                     },
//                     img: package.pImg,
//                     price: package.price.toString(),
//                     title: package.pTitle,
//                     cname: package.uName,
//                     pnum: package.pnum,
//                     email: package.uEmail,
//                   );
//                 });
//           } else if (snapshot.hasError) {
//             return Text("Error fetching data!");
//           } else {
//             return Container(
//               height: double.infinity,
//               child: ListView.builder(
//                 itemCount: 5,
//                 itemBuilder: (BuildContext context, int index) {
//                   return s();
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   void myDialog(Booking package) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             content: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextButton.icon(
//                     onPressed: () {
//                       del(package);
//                     },
//                     icon: Icon(Icons.delete),
//                     label: Text('delete'),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   del(Booking package) {
//     try {
//       FirebaseFirestore.instance
//           .collection('CBooking')
//           .doc(package.id)
//           .delete()
//           .then((value) => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => ConfirmBooking())));
//     } catch (e) {
//       print(e);
//     }
//   }
// }
