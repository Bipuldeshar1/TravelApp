import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/reusableComponent/CustomcardHOme.dart';
import 'package:project_3/reusableComponent/des.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';

class SearchDisplay extends StatefulWidget {
  String query;

  SearchDisplay({super.key, 
    required this.query,
  });

  @override
  State<SearchDisplay> createState() => _SearchDisplayState();
}

class _SearchDisplayState extends State<SearchDisplay> {
  @override
  Widget build(BuildContext context) {
    List<PackageModel> p = [];

    Future<List<PackageModel>> fetchproducts() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('Allposts')
          .where('title', isGreaterThanOrEqualTo: widget.query)
          .where('title', isLessThanOrEqualTo: '${widget.query}\uf8ff')
          .get();

      final userData = snapshot.docs
          .map((doc) => PackageModel.fromJson(doc.data()))
          .toList(); // map each document to a PackageModel object
      return userData;
    }

    @override
    void initState() {
      super.initState();
      fetchproducts();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.query),
        ),
        body: FutureBuilder(
            future: fetchproducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Des(package: snapshot.data![index]))),
                        child: CustomCardHome(
                          img: snapshot.data![index].img,
                          price: snapshot.data![index].price,
                          title: snapshot.data![index].title,
                          des: snapshot.data![index].description,
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Text("Error fetching data!");
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return const s();
                    },
                  ),
                );
              }
            }));
  }
}
