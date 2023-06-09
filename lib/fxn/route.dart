import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/userModel.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';
import 'package:project_3/screens/Home/nav.dart';

class Fxn {
  //this fxn is to navigate to user or admin i have to create a drop down for reg!
  //create a fav page and also do work for db !
  //insttall map properly and do extra resarches
  //admi side uis
  //home uis!
  //profile sectiomn
  //messaging-msg history and messsages!
  //ratings and rewviews!
  //reviews simply open tf!
  //ratring tf then store db!
  //for rating seperate db with product info and db!
  //multiple rating for individual product resarch needed!
  //see more pages design!
  //limit no of paroducts in home
  //validation in login for email
  // validation of char in phone number
//des page change color for back and fav buttomn!
//ph no detail in order section!
//if possivle dashboardin admin!
//ui for add product in admin
//on slide listview builder should show see more!
//slider in home if looks good!
//fav setion different card!
//notification!
//add confirmed booking in confirmed section!
//if possible create reject booking!
//notification to user for both above 2 points!
//select colors attractive for ui
//scaffold timer
//scaffold add where neded
  route(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    UserModel userModel =
        UserModel.fromMap(userData.data() as Map<String, dynamic>);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot a) {
      if (a.exists) {
        if (a.get('role') == 'admin') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminHomescreen()));
          final snackbar = SnackBar(
            content: Text('successful  loggedin'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BottomNav(firebaseUser: user, userModel: userModel)));
          final snackbar = SnackBar(
            content: Text('successful  loggedin'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
    });
  }
}
