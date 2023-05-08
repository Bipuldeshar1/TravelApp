import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:project_3/model/packagemodel.dart';

class Des extends StatefulWidget {
  // String title;
  // String des;
  // Des({required this.title, required this.des});
  final PackageModel package;

  Des({required this.package});

  @override
  State<Des> createState() => _DesState();
}

class _DesState extends State<Des> {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Package Description')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image(image: NetworkImage(widget.package.img)),
            ),
            Text(widget.package.title),
            Text(widget.package.description),
          ],
        ),
      ),
    );
  }
}
