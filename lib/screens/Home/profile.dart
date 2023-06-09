import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:project_3/reusableComponent/CustomButton.dart';
import 'package:project_3/screens/Home/pendingbooking.dart';
import 'package:project_3/screens/auth/login.dart';
import 'package:project_3/widgets/rating.dart';
import 'package:project_3/widgets/updateprofileform.dart';

import '../../model/userModel.dart';
import '../../reusableComponent/map/newmap.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  String imageUrl = '';
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    Future<List<UserModel>> fetchUserData() async {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      var data =
          querySnapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login())));
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchUserData(),
        builder: (contex, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white70,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snapshot
                                    .data![index].profilepic
                                    .toString())),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        snapshot.data![index].fullname
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        snapshot.data![index].email.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 25,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              snapshot.data![index].pnum.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PendingBooking()));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.book,
                                size: 25,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'bookings',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomButton(
                            text: 'update',
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateProfile()));
                            },
                            color: Colors.blue,
                            height: 40,
                            width: double.infinity)
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
