import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/reusableComponent/CustomButton.dart';
import 'package:project_3/reusableComponent/customCard.dart';
import 'package:project_3/reusableComponent/des.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';
import 'package:project_3/screens/Admin/update.dart';

class DashboardProducts extends StatefulWidget {
  @override
  State<DashboardProducts> createState() => _DashboardProductsState();
}

class _DashboardProductsState extends State<DashboardProducts> {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageController = TextEditingController();
  String imageUrl = '';

  File? images;

  @override
  Widget build(BuildContext context) {
    // List<PackageModel> packagemodel = [];
    //8 sec timer to update

    Future<List<PackageModel>> fetch() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('Allposts')
          .where('uId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = snapshot.docs
          .map((doc) => PackageModel.fromJson(doc.data()))
          .toList(); // map each document to a PackageModel object
      return userData;
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<PackageModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final package = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Des(package: package)));
                      });
                    },
                    child: CustomCard(
                      img: package.img,
                      price: package.price,
                      title: package.title,
                      des: package.description,
                      onpresss: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('update or delete'),
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomButton(
                                      text: 'delete',
                                      onPress: () {
                                        setState(() {
                                          delete(package.pId);
                                          Navigator.pop(context);
                                        });
                                      },
                                      color: Colors.white,
                                      height: 50,
                                      width: 50,
                                    ),
                                    CustomButton(
                                      text: 'update',
                                      onPress: () {
                                        // setState(() {
                                        //   Navigator.pop(context);
                                        //   showMyDialog(
                                        //     package.pId,
                                        //     package.title,
                                        //     package.description,
                                        //     package.price,
                                        //     package.img,
                                        //   );
                                        // });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Update(
                                                      package: package,
                                                    )));
                                      },
                                      color: Colors.white,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },

                      // ListTile(
                      //   title: Text(package.title),
                      //   trailing: IconButton(
                      //     icon: Icon(Icons.menu),
                      //     onPressed: () {
                      //       showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return AlertDialog(
                      //               title: Text('update or delete'),
                      //               content: Container(
                      //                 height: 100,
                      //                 width: 100,
                      //                 child: Column(
                      //                   children: [
                      //                     CustomButton(
                      //                       text: 'delete',
                      //                       onPress: () {
                      //                         setState(() {
                      //                           delete(package.pId);
                      //                           Navigator.pop(context);
                      //                         });
                      //                       },
                      //                       color: Colors.white,
                      //                       height: 50,
                      //                       width: 50,
                      //                     ),
                      //                     CustomButton(
                      //                       text: 'update',
                      //                       onPress: () {
                      //                         setState(() {
                      //                           showMyDialog(
                      //                             package.pId,
                      //                             package.title,
                      //                             package.description,
                      //                             package.price,
                      //                             package.img,
                      //                           );
                      //                         });
                      //                       },
                      //                       color: Colors.white,
                      //                       height: 50,
                      //                       width: 50,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           });
                      //     },
                      //   ),
                      // ),
                    ),
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

  void delete(String pid) {
    setState(() {
      FirebaseFirestore.instance.collection('Allposts').doc(pid).delete();
    });
  }

  showMyDialog(pid, title, descripiton, price, image) async {
    titleController.text = title;
    descriptionController.text = descripiton;
    priceController.text = price;
    imageController.text = image;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('update'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 200,
                          height: 200,
                          child: Image(image: NetworkImage(image))),
                      IconButton(
                        onPressed: () {
                          pickImage();
                          setState(() {});
                        },
                        icon: Icon(Icons.update),
                      ),
                    ],
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'title',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'description',
                    ),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: 'price',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    FirebaseFirestore.instance
                        .collection('Allposts')
                        .doc(pid)
                        .update({
                      'title': titleController.text.toString(),
                      'description': descriptionController.text.toString(),
                      'price': priceController.text.toString(),
                      'img': imageUrl
                    }).then((value) => Navigator.pop(context));
                  });
                },
                child: const Text('update'),
              )
            ],
          );
        });
  }

  void pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      String uniqueid = DateTime.now().microsecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref();
      Reference referenceImage = reference.child('product_Image_post');
      Reference referenceImageToUpload = referenceImage.child(uniqueid);

      await referenceImageToUpload.putFile(File(image!.path));
      print('sent');
      imageUrl = await referenceImageToUpload.getDownloadURL();
      print(imageUrl);

      images = File(image.path);
    } catch (e) {
      print(e);
    }
  }
}
