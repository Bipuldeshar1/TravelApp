import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/reusableComponent/CustomcardHOme.dart';
import 'package:project_3/reusableComponent/des.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<PackageModel>> fetch() async {
      var document = await FirebaseFirestore.instance
          .collection('Allposts')
          .orderBy('ratings', descending: true)
          .get();
      var posts =
          document.docs.map((e) => PackageModel.fromJson(e.data())).toList();
      return posts;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Allposts'),
      ),
      body: FutureBuilder(
        future: fetch(),
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
        },
      ),
    );
  }
}
