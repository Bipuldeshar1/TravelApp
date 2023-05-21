import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';

import 'package:project_3/reusableComponent/CustomcardHOme.dart';
import 'package:project_3/reusableComponent/customCard.dart';
import 'package:project_3/reusableComponent/simmer/s.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';

import 'package:project_3/widgets/components/Top_Section.dart';
import 'package:project_3/widgets/search.dart';

import '../../model/packagemodel.dart';
import '../../reusableComponent/CustomButton.dart';
import '../../reusableComponent/des.dart';
import '../../widgets/components/Label_Section.dart';
import '../auth/login.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var priceController = TextEditingController();
    var descriptionController = TextEditingController();
    var imageController = TextEditingController();

    Future<List<PackageModel>> Allfetch() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('Allposts')
          .orderBy('price', descending: true)
          .get();
      final userData = snapshot.docs
          .map((doc) => PackageModel.fromJson(doc.data()))
          .toList(); // map each document to a PackageModel object
      return userData;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            //   elevation: 0,
            //   centerTitle: false,
            //   flexibleSpace: Flexible(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const Text(
            //           'Home SCreen',
            //           style: TextStyle(fontSize: 30),
            //         ),
            //         IconButton(
            //           onPressed: () {},
            //           icon: Icon(
            //             Icons.notification_important_outlined,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'LOgo',
                    style: TextStyle(fontSize: 15),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_active,
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                'where do you! \n want  go?',
                style: TextStyle(fontSize: 50),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: SearchSection(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: LabelSection(text: 'recommened', style: heading1),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(child: TopSection()),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: LabelSection(text: 'Allposts', style: heading1),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                  future: Allfetch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Des(
                                                  package:
                                                      snapshot.data![index])));
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
                  }),
            )
            // SliverList(delegate: SliverChildBuilderDelegate(
            //   (context, index) {
            //     return FutureBuilder(
            //         future: Allfetch(),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData) {
            //             return
            //              Container(
            //                 height: MediaQuery.of(context).size.height * 1,
            //                 child: ListView.builder(
            //                     itemCount: snapshot.data!.length,
            //                     itemBuilder: (context, index) {
            //                       return InkWell(
            //                         onTap: () {
            //                           setState(() {
            //                             Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                     builder: (context) => Des(
            //                                         package: snapshot
            //                                             .data![index])));
            //                           });
            //                         },
            //                         child: CustomCardHome(
            //                           img: snapshot.data![index].img,
            //                           price: snapshot.data![index].price,
            //                           title: snapshot.data![index].title,
            //                           des: snapshot.data![index].description,
            //                         ),
            //                       );
            //                     }));
            //           } else if (snapshot.hasError) {
            //             return const Text("Error fetching data!");
            //           } else if (snapshot.data == null) {
            //             return const Center(child: Text('no products posted'));
            //           } else {
            //             return const Center(child: CircularProgressIndicator());
            //           }
            //         });
            //   },
            // ))
          ],
        ),
      ),
    );
  }
}
