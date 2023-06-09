import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/screens/Admin/product.dart';

class Update extends StatefulWidget {
  PackageModel package;
  Update({
    required this.package,
  });
  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  String imageUrl = '';

  File? images;

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.package.title;
    descriptionController.text = widget.package.description;
    priceController.text = widget.package.price;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 300,
                    height: 200,
                    child: images != null
                        ? Container(
                            width: 300,
                            child: Image.file(
                              images!,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Image(
                            width: 300,
                            image: NetworkImage(
                              widget.package.img,
                            ),
                          ),
                  ),

                  // Container(
                  //     width: 200,
                  //     height: 200,
                  //     child: Image(image: NetworkImage(widget.package.img))),

                  IconButton(
                    onPressed: () {
                      pickImage();
                      setState(() {});
                    },
                    icon: Icon(Icons.update),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                maxLines: null,
                minLines: 1,
                maxLength: 200,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    FirebaseFirestore.instance
                        .collection('Allposts')
                        .doc(widget.package.pId)
                        .update({
                      'title': titleController.text.toString(),
                      'description': descriptionController.text.toString(),
                      'price': priceController.text.toString(),
                      'img': imageUrl
                    }).then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardProducts())));
                  });
                },
                child: const Text('update'),
              )
            ],
          ),
        ),
      ),
    );
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

      setState(() {
        images = File(image.path);
      });
    } catch (e) {
      print(e);
    }
  }
}
