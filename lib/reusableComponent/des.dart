import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:project_3/fxn/book.dart';

import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/model/userModel.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'package:project_3/reusableComponent/CustomButton.dart';
import 'package:project_3/reusableComponent/map/desmap.dart';

import 'package:project_3/widgets/rating.dart';

class Des extends StatefulWidget {
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
  var ratingController = TextEditingController();
  var reviewController = TextEditingController();
  String name = '';
  String pnumb = '';
  Future<void> getName() async {
    try {
      final x = await FirebaseFirestore.instance
          .collection('Users_Details')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (x.exists) {
        final data = x.data();
        name = data!['name'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNum() async {
    final x = await FirebaseFirestore.instance
        .collection('Users_Details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (x.exists) {
      final data = x.data();
      pnumb = data!['pnum'];
    }
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    //  final uemail = FirebaseAuth.instance.currentUser!.email;

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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Positioned(
                      top: 16.0,
                      left: 16.0,
                      child: CircleAvatar(
                        backgroundColor:
                            Colors.lightGreenAccent.withOpacity(0.5),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: CircleAvatar(
                        backgroundColor:
                            Colors.lightGreenAccent.withOpacity(0.5),
                        child: IconButton(
                          icon: Icon(Icons.favorite_border),
                          color: Colors.black,
                          onPressed: () {
                            addFav(
                              widget.package.img,
                              widget.package.pId,
                              widget.package.description,
                              widget.package.price,
                              widget.package.title,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: RatingBar(
                    rating: widget.package.ratings == null
                        ? []
                        : widget.package.ratings,
                    ratingCount: 15,
                  ),
                ),
                CustomButton(
                    text: 'reviews',
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('update or delete'),
                            content: Container(
                              height: 200,
                              width: 100,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: reviewController,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  CustomButton(
                                    text: 'submit',
                                    onPress: () {
                                      FirebaseFirestore.instance
                                          .collection('reviews')
                                          .doc()
                                          .set({
                                        'review': reviewController.text,
                                        'sid': FirebaseAuth
                                            .instance.currentUser!.uid,
                                        'sEmail': FirebaseAuth
                                            .instance.currentUser!.email,
                                        'sName': name,
                                        'uid': widget.package.uId,
                                        'uemail': widget.package.uemail,
                                        'title': widget.package.title,
                                        'descripiton':
                                            widget.package.description,
                                        'price': widget.package.price,
                                      });
                                    },
                                    color: Colors.blue,
                                    height: 50,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    color: Colors.blue,
                    height: 30,
                    width: 80)
              ],
            ),
          )),
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
                'Rs  ${widget.package.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'contact info\n${widget.package.n}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CustomButton(
              text: 'map',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DesMap(
                              a: widget.package.x.toString(),
                              b: widget.package.y.toString(),
                            )));
              },
              color: Colors.amber,
              height: 40,
              width: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
                onPressed: () {
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  final uemail = FirebaseAuth.instance.currentUser!.email;
                  final uname = name.toString();
                  final pnum = pnumb.toString();
                  final date = DateTime.now().microsecondsSinceEpoch;
                  final sid = widget.package.uId;
                  final sEmail = widget.package.uemail;
                  payWithKhalti(
                    uid,
                    uname,
                    uemail,
                    date,
                    widget.package.pId,
                    widget.package.title,
                    widget.package.description,
                    widget.package.img,
                    int.parse(widget.package.price),
                    sid,
                    sEmail,
                    pnum,
                  );
                },
                child: Text('pay')),
          )
        ],
      ),
    );
  }

  void payWithKhalti(
    uid,
    String uname,
    String? uemail,
    date,
    String pId,
    String title,
    String description,
    String img,
    int price,
    sid,
    sEmail,
    pnum,
  ) {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: price * 100, //in paisa
        productIdentity: pId,
        productName: title,
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: (PaymentSuccessModel success) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Payment Successful'),
              actions: [
                SimpleDialogOption(
                    child: const Text('OK'),
                    onPressed: () {
                      Books b = new Books();
                      b.book(uid, uname, uemail, date, pId, title, description,
                          img, price, sid, sEmail, pnum);
                      Navigator.pop(context);
                      print('oks');
                    })
              ],
            );
          },
        );
      },
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() async {
    final snackbar = SnackBar(content: Text('cancelled'));
    await ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void addFav(
      String img, String pId, String description, String price, String title) {
    try {
      var x = FirebaseFirestore.instance.collection('fav').doc(pId).set({
        'title': title,
        'price': price,
        'description': description,
        'img': img,
        'pId': pId,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      }).then((value) async {
        var snackbar = SnackBar(content: Text('addeed to favourite'));
        await ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
