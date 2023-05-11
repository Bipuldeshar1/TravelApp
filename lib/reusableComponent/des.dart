import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/model/userModel.dart';

import 'package:project_3/reusableComponent/CustomButton.dart';

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
  String name = '';
  Future<void> getName() async {
    final x = await FirebaseFirestore.instance
        .collection('Users_Details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (x.exists) {
      final data = x.data();
      name = data!['name'];
    }
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    final uemail = FirebaseAuth.instance.currentUser!.email;
    final uname = getName();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(children: [
              Image.network(
                widget.package.img,
                fit: BoxFit.fill,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .6,
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                top: 16.0,
                right: 16.0,
                child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.package.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 8.0),
                  Text(
                    '4.5 (1234 ratings)',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'description:\n${widget.package.description}',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Rs ${widget.package.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  text: 'book now',
                  onPress: () {
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    final uemail = FirebaseAuth.instance.currentUser!.email;
                    final uname = name.toString();
                    final date = DateTime.now().microsecondsSinceEpoch;
                    final sid = widget.package.uId;
                    final sEmail = widget.package.uemail;

                    book(
                        uid,
                        uname,
                        uemail,
                        date,
                        widget.package.pId,
                        widget.package.title,
                        widget.package.description,
                        widget.package.img,
                        widget.package.price,
                        sid,
                        sEmail);
                  },
                  color: Colors.blue,
                  height: 30,
                  width: double.infinity,
                )),
          ),
        ],
      ),

      //  SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // Container(
      //       //   width: 200,
      //       //   height: 200,
      //       //   child: Image(image: NetworkImage(widget.package.img)),
      //       // ),
      //       // Text(widget.package.title),
      //       // Text(widget.package.description),
      //       // Text(name.toString()),
      //       // Text(FirebaseAuth.instance.currentUser!.email.toString()),
      //       // Text(widget.package.uemail.toString()),

      //       CustomButton(
      //         text: 'book now',
      //         onPress: () {
      //           final uid = FirebaseAuth.instance.currentUser!.uid;
      //           final uemail = FirebaseAuth.instance.currentUser!.email;
      //           final uname = name.toString();
      //           final date = DateTime.now().microsecondsSinceEpoch;
      //           final sid = widget.package.uId;
      //           final sEmail = widget.package.uemail;

      //           book(
      //             uid,
      //             uname,
      //             uemail,
      //             date,
      //             widget.package.pId,
      //             widget.package.title,
      //             widget.package.description,
      //             widget.package.img,
      //             widget.package.price,
      //             sid,
      //             sEmail,
      //           );
      //         },
      //         color: Colors.blue,
      //         height: 30,
      //         width: double.infinity,
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  void book(
    String uid,
    String uname,
    String? uemail,
    int date,
    String pId,
    String title,
    String description,
    String img,
    String price,
    String? sid,
    String? sEmail,
  ) {
    final date = DateTime.now();
    try {
      FirebaseFirestore.instance.collection('orders').doc().set({
        'uId': uid,
        'uName': uname,
        'uEmial': uemail,
        'bookingDate': date,
        'pId': pId,
        'ptitle': title,
        'pdescription': description,
        'pimg': img,
        'price': price,
        'sid': sid,
        'sEmail': sEmail,
      });
    } catch (e) {
      print(e);
    }
  }
}
