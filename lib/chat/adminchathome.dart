import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/chat/chatRoomPage.dart';
import 'package:project_3/chat/searchPAge.dart';
import 'package:project_3/model/chatRoomModel.dart';
import 'package:project_3/model/firebasehelper.dart';
import 'package:project_3/model/userModel.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';
import 'package:project_3/screens/auth/login.dart';

class HomePageChatAdmin extends StatefulWidget {
  UserModel userModel;
  User firebaseUser;
  HomePageChatAdmin({
    required this.userModel,
    required this.firebaseUser,
  });
  @override
  State<HomePageChatAdmin> createState() => _HomePageChatAdminState();
}

class _HomePageChatAdminState extends State<HomePageChatAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('chat'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SafeArea(
      //     child: Container(
      //       child: StreamBuilder(
      //           stream: FirebaseFirestore.instance
      //               .collection("chatrooms")
      //               .where("users", arrayContains: widget.userModel.uid)
      //               .orderBy('createdon', descending: true)
      //               .snapshots(),
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.active) {
      //               if (snapshot.hasData) {
      //                 QuerySnapshot chatRoomSnapshot =
      //                     snapshot.data as QuerySnapshot;

      //                 return ListView.builder(
      //                   itemCount: chatRoomSnapshot.docs.length,
      //                   itemBuilder: (context, index) {
      //                     ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
      //                         chatRoomSnapshot.docs[index].data()
      //                             as Map<String, dynamic>);

      //                     Map<String, dynamic> participants =
      //                         chatRoomModel.participants!;

      //                     List<String> participantsKeys =
      //                         participants.keys.toList();

      //                     // participants.remove(widget.userModel.uid);

      //                     return FutureBuilder(
      //                       future: FirebaseHelper.getUserModelById(
      //                           participantsKeys[0]),
      //                       builder: (context, userData) {
      //                         if (userData.connectionState ==
      //                             ConnectionState.done) {
      //                           if (userData.data != null) {
      //                             UserModel targetUser =
      //                                 userData.data as UserModel;

      //                             return Column(
      //                               children: [
      //                                 Container(
      //                                   decoration: BoxDecoration(
      //                                       border: Border.symmetric()),
      //                                   child: ListTile(
      //                                     onTap: () {
      //                                       Navigator.push(
      //                                           context,
      //                                           MaterialPageRoute(
      //                                               builder: (context) =>
      //                                                   ChatRoomPage(
      //                                                     chatroom:
      //                                                         chatRoomModel,
      //                                                     targetUser:
      //                                                         targetUser,
      //                                                     firebaseUser: widget
      //                                                         .firebaseUser,
      //                                                     userModel:
      //                                                         widget.userModel,
      //                                                   )));
      //                                     },
      //                                     leading: CircleAvatar(
      //                                         backgroundImage: NetworkImage(
      //                                             targetUser.profilepic
      //                                                 .toString())),
      //                                     title: Text(
      //                                         targetUser.fullname.toString()),
      //                                     subtitle: Text(chatRoomModel
      //                                         .lastMessage
      //                                         .toString()),
      //                                   ),
      //                                 ),
      //                                 Divider(
      //                                   color: Colors.black,
      //                                 )
      //                               ],
      //                             );
      //                           } else {
      //                             return Container();
      //                           }
      //                         } else {
      //                           return Container();
      //                         }
      //                       },
      //                     );
      //                   },
      //                 );
      //               } else if (snapshot.hasError) {
      //                 return Center(
      //                   child: Text(snapshot.error.toString()),
      //                 );
      //               } else {
      //                 return Center(
      //                   child: Text('no chats'),
      //                 );
      //               }
      //             } else {
      //               return Center(
      //                 child: Text(snapshot.error.toString()),
      //               );
      //             }
      //           }),
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => SearchPage(
      //                   userModel: widget.userModel,
      //                   firebaseUser: widget.firebaseUser,
      //                 )));
      //   },
      //   child: Icon(Icons.search),
      // ),
    );
  }
}
