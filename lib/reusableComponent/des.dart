import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:project_3/chat/chatRoomPage.dart';
import 'package:project_3/const/style.dart';
import 'package:project_3/fxn/book.dart';

import 'package:project_3/model/packagemodel.dart';

import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:project_3/model/reviewmodel.dart';

import 'package:project_3/reusableComponent/CustomButton.dart';
import 'package:project_3/reusableComponent/map/desmap.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';
import 'package:project_3/screens/Home/home.dart';
import 'package:project_3/screens/Home/nav.dart';

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
  String role = '';
  String pnumb = '';
  int totalRatings = 0;
  double sumRatings = 0.0;
  double averageRating = 0.0;
  final _formKey = GlobalKey<FormState>();

  Future<List<ReviewModel>> fetchReview() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('pid', isEqualTo: widget.package.pId)
        .get();
    final userData = snapshot.docs
        .map((doc) => ReviewModel.fromJson(doc.data()))
        .toList(); // map each document to a PackageModel object
    return userData;
  }

  Future<void> getName() async {
    try {
      final x = await FirebaseFirestore.instance
          .collection('users')
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

  Future<void> getrole() async {
    try {
      final x = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (x.exists) {
        final data = x.data();
        role = data!['role'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNum() async {
    final x = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (x.exists) {
      final data = x.data();
      pnumb = data!['pnum'] ?? "";
    }
  }

  @override
  void initState() {
    super.initState();
    getName();
    getNum();
    getrole();
    fetchRatings();
  }

  void fetchRatings() async {
    // Fetch the document with the given currentPid from the 'ratings' collection
    var currentPid = widget.package.pId;
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore
        .instance
        .collection('ratings')
        .doc(currentPid)
        .get();

    if (docSnapshot.exists) {
      List<dynamic> ratings = docSnapshot.data()?['ratings'] as List<dynamic>;

      for (var ratingObj in ratings) {
        String pid = ratingObj['pid'];
        String rating = ratingObj['rating'];
        String rid = ratingObj['rid'];

        if (pid == currentPid) {
          var ratingValue = double.parse(rating);

          if (ratingValue is int) {
            sumRatings += ratingValue.toDouble();
          } else if (ratingValue is double) {
            sumRatings += ratingValue;
          }

          totalRatings++;
        }
      }

      if (totalRatings > 0) {
        averageRating = sumRatings / totalRatings;
        print('Average Rating: $averageRating');
        print('Sum of Ratings: $sumRatings');
      } else {
        print('No ratings available for the current PID.');
      }
    } else {
      print(
          'Document with the current PID does not exist in the ratings collection.');
    }

    setState(() {});
  }

  void sendRating() async {
    //old

    String packageId = widget.package.pId;

    // Fetch the current list of ratings
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(packageId)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      List<dynamic> ratingsList = data['ratings'] ?? [];

      // Add the new rating to the existing list
      ratingsList.add({
        'rating': ratingController.text,
        'rid': FirebaseAuth.instance.currentUser!.uid,
        'pid': packageId,
      });

      // Update the document with the modified list
      await FirebaseFirestore.instance
          .collection('ratings')
          .doc(packageId)
          .update({'ratings': ratingsList})
          .then((value) => FirebaseFirestore.instance
                  .collection('Allposts')
                  .doc(widget.package.pId)
                  .update({
                'ratings': averageRating,
              }))
          .then((value) => Navigator.pop(context));
    } else {
      // Handle the case when the document does not exist
      print('Document not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final uemail = FirebaseAuth.instance.currentUser!.email;
    final uname = name.toString();
    final pnum = pnumb.toString();

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
          role == 'user'
              ? SliverToBoxAdapter(
                  child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () async {
                            // var x = FirebaseFirestore.instance
                            //     .collection('ratings')
                            //     .doc(widget.package.pId)
                            //     .collection('ratings')
                            //     .where('rid',
                            //         isEqualTo:
                            //             FirebaseAuth.instance.currentUser!.uid);
                            String packageId = widget.package.pId;

// Fetch the current list of ratings
                            DocumentSnapshot documentSnapshot =
                                await FirebaseFirestore.instance
                                    .collection('ratings')
                                    .doc(packageId)
                                    .get();

                            if (documentSnapshot.exists) {
                              Map<String, dynamic> data = documentSnapshot
                                  .data() as Map<String, dynamic>;
                              List<dynamic> ratingsList = data['ratings'] ?? [];

                              bool hasGivenRating = false;

                              for (var rating in ratingsList) {
                                if (rating['rid'] ==
                                    FirebaseAuth.instance.currentUser!.uid) {
                                  hasGivenRating = true;
                                  break;
                                }
                              }

                              if (hasGivenRating) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Already provided ratings'),
                                        content: CustomButton(
                                          text: 'ok',
                                          onPress: () {
                                            Navigator.pop(context);
                                          },
                                          color: Colors.blue,
                                          height: 30,
                                          width: 50,
                                        ),
                                      );
                                    });
                                print('User has given a rating.');
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Rating'),
                                        actions: [
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                // TextFormField(
                                                //   controller: ratingController,
                                                //   validator: (value) {
                                                //     if (value!.isEmpty) {
                                                //       return 'cannot be null';
                                                //     }

                                                //     if (value 6) {
                                                //       return 'review should be below 5';
                                                //     } else {
                                                //       return null;
                                                //     }
                                                //   },
                                                // ),
                                                TextFormField(
                                                  controller: ratingController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'cannot be null';
                                                    }

                                                    final rating =
                                                        double.tryParse(value);

                                                    if (rating != null &&
                                                        rating > 5) {
                                                      return 'review should be below 5';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),

                                                ElevatedButton(
                                                  child: Text('ok'),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                      sendRating();
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                                print('User has not given a rating.');
                              }
                            } else {
                              // The document does not exist or ratings list is empty
                              // Perform your desired actions here
                              print('No ratings found for the package.');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ratings',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingBar(
                                    rating: averageRating
                                        .ceil()
                                        .floor()
                                        .toDouble()),
                              ],
                            ),
                          )),
                      CustomButton(
                          text: 'reviews',
                          onPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Add a review'),
                                  content: Container(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: reviewController,
                                            maxLines: null,
                                            minLines: 1,
                                            maxLength: 200,
                                            textInputAction:
                                                TextInputAction.newline,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'cannot be null';
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 50,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          CustomButton(
                                            text: 'submit',
                                            onPress: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                FirebaseFirestore.instance
                                                    .collection('reviews')
                                                    .doc()
                                                    .set({
                                                  'pid': widget.package.pId,
                                                  'review':
                                                      reviewController.text,
                                                  'sid': FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  'sEmail': FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .email,
                                                  'sName': name,
                                                  'uid': widget.package.uId,
                                                  'uemail': FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .email,
                                                  'title': widget.package.title,
                                                  'descripiton': widget
                                                      .package.description,
                                                  'price': widget.package.price,
                                                }).then((value) =>
                                                        Navigator.pop(context));
                                              }
                                            },
                                            color: Colors.blue,
                                            height: 50,
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
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
                ))
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ratings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RatingBar(
                          rating: averageRating.ceil().floor().toDouble(),
                        ),
                      ],
                    ),
                  ),
                ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.package.description}',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Rs ${widget.package.price}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact info:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${widget.package.n}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${widget.package.uemail}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: CustomButton(
          //     text: 'map',
          //     onPress: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => DesMap(
          //                     a: widget.package.x.toString(),
          //                     b: widget.package.y.toString(),
          //                   )));
          //     },
          //     color: Colors.amber,
          //     height: 40,
          //     width: 10,
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location info:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: DesMap(
                      a: widget.package.x.toString(),
                      b: widget.package.y.toString(),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => DesMap(
                  //           a: widget.package.x.toString(),
                  //           b: widget.package.y.toString(),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: const Text(
                  //     'Browse Location',
                  //     style: TextStyle(
                  //       color: Colors.blueGrey,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          role == 'user'
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 5, top: 5),
                    child: ElevatedButton(
                        onPressed: () {
                          final uid = FirebaseAuth.instance.currentUser!.uid;
                          final uemail =
                              FirebaseAuth.instance.currentUser!.email;
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
                        child: Text('Book')),
                  ),
                )
              : SliverToBoxAdapter(),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
          //     child: ElevatedButton(
          //         onPressed: () {
          //           final uid = FirebaseAuth.instance.currentUser!.uid;
          //           final uemail = FirebaseAuth.instance.currentUser!.email;
          //           final uname = name.toString();
          //           final pnum = pnumb.toString();
          //           final date = DateTime.now().microsecondsSinceEpoch;
          //           final sid = widget.package.uId;
          //           final sEmail = widget.package.uemail;
          //           payWithKhalti(
          //             uid,
          //             uname,
          //             uemail,
          //             date,
          //             widget.package.pId,
          //             widget.package.title,
          //             widget.package.description,
          //             widget.package.img,
          //             int.parse(widget.package.price),
          //             sid,
          //             sEmail,
          //             pnum,
          //           );
          //         },
          //         child: Text('Book')),
          //   ),
          // )

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 200,
              child: FutureBuilder(
                future: fetchReview(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: 200,
                      height: 200,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final package = snapshot.data![index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.3), // Shadow color
                                      spreadRadius: 2, // Shadow spread radius
                                      blurRadius: 5, // Shadow blur radius
                                      offset: Offset(0, 3), // Shadow offset
                                    )
                                  ],
                                ),
                                height: 120,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          package.title,
                                          style: heading2,
                                        ),
                                        const Text(
                                          'review:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Container(
                                          width: 300,
                                          child: Text(
                                            package.review,
                                            style: p3,
                                          ),
                                        ),
                                        const Text(
                                          'reviewed by:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(package.uemail, style: p3),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
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
            ),
          ),
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
            Books b = new Books();
            b.book(uid, uname, uemail, date, pId, title, description, img,
                price, sid, sEmail, pnum);
            return AlertDialog(
              title: const Text('Payment Successful'),
              actions: [
                SimpleDialogOption(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
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
