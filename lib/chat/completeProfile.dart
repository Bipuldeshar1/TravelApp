import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_3/chat/homePageChat.dart';
import 'package:project_3/model/userModel.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  CompleteProfile({
    required this.userModel,
    required this.firebaseUser,
  });

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('upload pp'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    selectImage(ImageSource.gallery);
                  },
                  title: Text('select a photo'),
                ),
                ListTile(
                  title: Text('take a photo'),
                )
              ],
            ),
          );
        });
  }

  void checkValues() {
    String fullname = fullNameController.text.trim();

    if (fullname == "" || imageFile == null) {
      print("Please fill all the fields");
      //elper.showAlertDialog(context, "Incomplete Data", "Please fill all the fields and upload a profile picture");
    } else {
      print("Uploading data..");
      uploadData();
    }
  }

  void uploadData() async {
    //UIHelper.showLoadingDialog(context, "Uploading image..");

    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepictures")
        .child(widget.userModel.uid.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();
    String? fullname = fullNameController.text.trim();

    widget.userModel.fullname = fullname;
    widget.userModel.profilepic = imageUrl;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      print("Data uploaded!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return HomePageChat(
              userModel: widget.userModel, firebaseUser: widget.firebaseUser);
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'complete profile',
        ),
      ),
      body: SafeArea(
          child: Container(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                showPhotoOptions();
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    (imageFile != null ? FileImage(imageFile!) : null),
                child: (imageFile == null)
                    ? const Icon(
                        Icons.person,
                        size: 60,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'name'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                checkValues();
              },
              child: Text('submit'),
            )
          ],
        ),
      )),
    );
  }
}
