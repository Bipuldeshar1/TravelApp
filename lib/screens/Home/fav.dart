import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/reusableComponent/customCardfav.dart';
import 'package:project_3/reusableComponent/des.dart';

import '../../reusableComponent/simmer/s.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
//     Future<List<PackageModel>>fav()async{
// var documentSnapshot= await FirebaseFirestore.instance.collection('fav').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
//   final favData= documentSnapshot.docs.map((e) => PackageModel.fromJson(e.data())).toList();
//   return favData;
//     }
    Stream<List<PackageModel>> fav() async* {
      try {
        var documentSnapshot = await FirebaseFirestore.instance
            .collection('fav')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
        final favData = documentSnapshot.docs
            .map((e) => PackageModel.fromJson(e.data()))
            .toList();
        yield favData;
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('favourite'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<PackageModel>>(
        stream: fav(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 500,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return s();
                },
              ),
            );
            ;
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text('No favourite added'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Des(package: snapshot.data![index])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomCardFav(
                        img: snapshot.data![index].img,
                        price: snapshot.data![index].price,
                        title: snapshot.data![index].title,
                        onpresss: () {
                          setState(() {
                            del(snapshot.data![index].pId);
                          });
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  void del(String pId) {
    try {
      FirebaseFirestore.instance
          .collection('fav')
          .doc(pId)
          .delete()
          .then((value) {
        final snackbar = SnackBar(content: Text('removed successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
