// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:project_3/fxn/route.dart';
// import 'package:project_3/screens/Admin/adminHOme.dart';
// import 'package:project_3/screens/Home/nav.dart';
// import 'package:project_3/screens/auth/login.dart';

// class SplashScreen extends StatefulWidget {
//   SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   Fxn f = new Fxn();

//   void initState() {
//     super.initState();
//     startSplashScreen();
//   }

//   startSplashScreen() async {
//     var duration = const Duration(seconds: 3);
//     return Timer(duration, () {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) =>
//               FirebaseAuth.instance.currentUser != null ? routes() : Login(),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff329cef),
//       body: Container(
//         child: Image.asset(
//           "lib/assets/image.png",
//           width: double.infinity,
//           height: double.infinity,
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }

//   Widget routes() {
//     User? user = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection('Users_Details')
//         .doc(user!.uid)
//         .get()
//         .then((DocumentSnapshot a) {
//       if (a.exists) {
//         if (a.get('role') == 'admin') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AdminHomescreen()),
//           );
//           final snackbar = SnackBar(content: Text('Successful login'));
//           ScaffoldMessenger.of(context).showSnackBar(snackbar);
//         } else {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => BottomNav(firebaseUser: firebaseUser, userModel: userModel)),
//           );
//           final snackbar = SnackBar(content: Text('Successful login'));
//           ScaffoldMessenger.of(context).showSnackBar(snackbar);
//         }
//       }
//     });
//     return Login();
//   }
// }
