import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_3/reusableComponent/CustomcardHOme.dart';
import 'package:project_3/reusableComponent/des.dart';

import '../../model/packagemodel.dart';
import '../../reusableComponent/simmer/s.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({super.key});

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  @override
  Widget build(BuildContext context) {
    Stream<List<PackageModel>> fetch() {
      return FirebaseFirestore.instance
          .collection('Allposts')
          .orderBy('createdOn', descending: true)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => PackageModel.fromJson(doc.data()))
              .toList());
    }

    return StreamBuilder(
        stream: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 430,
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
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
                        child: CustomCardHome(
                          img: snapshot.data![index].img,
                          price: snapshot.data![index].price,
                          title: snapshot.data![index].title,
                          des: snapshot.data![index].description,
                        ));
                  }),
            );
          } else if (snapshot.hasError) {
            return const Text("Error fetching data!");
          } else {
            return SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return const s();
                },
              ),
            );
          }
        });
  }
}
