import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/widgets/components/Card_Top.dart';

import '../../reusableComponent/des.dart';
import '../../reusableComponent/simmer/s.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key});

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    // Future<List<PackageModel>> recom() async {
    //   final snapshot = await FirebaseFirestore.instance
    //       .collection('Allposts')
    //       .orderBy('price', descending: true)
    //       .get();
    //   final userData = snapshot.docs
    //       .map((doc) => PackageModel.fromJson(doc.data()))
    //       .toList(); // map each document to a PackageModel object
    //   return userData;
    // }
    Stream<List<PackageModel>> recom() {
      return FirebaseFirestore.instance
          .collection('Allposts')
          .orderBy('ratings', descending: true)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => PackageModel.fromJson(doc.data()))
              .toList());
    }

    return StreamBuilder(
        stream: recom(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    var package = snapshot.data![index];
                    return InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Des(package: snapshot.data![index])));
                          });
                        },
                        child: Cart(
                          image: package.img,
                          name: package.title,
                          price: package.price,
                        ));
                  }),
            );
          } else if (snapshot.hasError) {
            return const Text("Error fetching data!");
          } else {
            return Container(
              height: 500,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return s();
                },
              ),
            );
          }
        });
  }
}
