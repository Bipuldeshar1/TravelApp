import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/chat/adminchathome.dart';

import 'package:project_3/model/userModel.dart';

import 'package:project_3/screens/Admin/addProducts.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';
import 'package:project_3/screens/Admin/pendingBooking.dart';

import 'package:project_3/screens/Admin/product.dart';
import 'package:project_3/screens/Admin/review.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 45, 20, 50),
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Home(text: 'Home', onClick: () => selectedItem(context, 0)),
              // AddAdmin(
              //     text: 'AddAdmin', onClick: () => selectedItem(context, 1)),
              orders(
                  text: ' Bookings', onClick: () => selectedItem(context, 1)),
              AddProducts(
                  text: 'Add Foods',
                  onClick: () => selectedItem(context, 2)),
              product(text: 'Posts', onClick: () => selectedItem(context, 3)),
              Review(text: 'Reviews', onClick: () => selectedItem(context, 4)),

              homePageChat(
                  text: 'Chat', onClick: () => selectedItem(context, 5)),
            ],
          ),
        ),
      ),
    );
  }

//drawer item redirect to corresponding page due to this fxn
  selectedItem(context, int i) async {
    User? user = FirebaseAuth.instance.currentUser;

    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    UserModel userModel =
        UserModel.fromMap(userData.data() as Map<String, dynamic>);

    switch (i) {
      case 0:
        Navigator.of(context)
            .push((MaterialPageRoute(builder: (context) => const AdminHomescreen())));
        break;
      case 1:
        Navigator.of(context)
            .push((MaterialPageRoute(builder: (context) => const PendingBooking())));
        break;
      case 2:
        Navigator.of(context).push(
            (MaterialPageRoute(builder: (context) => const AddProductScreen())));
        break;
      case 3:
        Navigator.of(context).push(
            (MaterialPageRoute(builder: (context) => const DashboardProducts())));
        break;
      case 4:
        Navigator.of(context)
            .push((MaterialPageRoute(builder: (context) => const ReviewScreen())));
        break;

      case 5:
        Navigator.of(context).push((MaterialPageRoute(
            builder: (context) =>
                HomePageChatAdmin(userModel: userModel, firebaseUser: user))));
        break;
    }
  }

//function for drawer items
  product({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  AddProducts({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  orders({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  Home({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  homePageChat({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  Review({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  CBooking({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }
}
