import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_3/reusableComponent/CustomButton.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String imageUrl = '';
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final numberController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    pickImage() async {
      try {
        final pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        String uniqueId = DateTime.now().microsecondsSinceEpoch.toString();
        Reference reference = FirebaseStorage.instance.ref();
        Reference referenceImage = reference.child('product_Image_post');
        Reference referenceImageToUpload = referenceImage.child(uniqueId);
        try {
          await referenceImageToUpload.putFile(File(pickedImage!.path));
          imageUrl = await referenceImageToUpload.getDownloadURL();
          print(imageUrl);
        } catch (e) {
          print(e);
        }
        if (pickedImage != null) {
          setState(() {
            selectedImage = File(pickedImage.path);
          });
        }
      } catch (e) {
        print(e);
      }
    }

    @override
    void initState() {
      super.initState();
      pickImage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('update profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'cannot be empty';
                      } else if (value.length != 10) {
                        return 'must be 10 char';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      text: 'update',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          update(nameController.text, numberController.text,
                              imageUrl);
                        }
                      },
                      color: Colors.blue,
                      height: 50,
                      width: double.infinity)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void update(String name, String number, String imageUrl) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
      'number': number,
      'profilepic': imageUrl,
    }).then((value) => Navigator.pop(context));
  }
}
