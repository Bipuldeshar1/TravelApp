import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/chat/chatRoomPage.dart';
import 'package:project_3/chat/searchPAge.dart';
import 'package:project_3/model/chatRoomModel.dart';
import 'package:project_3/model/firebasehelper.dart';
import 'package:project_3/model/userModel.dart';
import 'package:project_3/screens/auth/login.dart';

class HomePageChat extends StatefulWidget {
  UserModel userModel;
  User firebaseUser;
  HomePageChat({
    required this.userModel,
    required this.firebaseUser,
  });
  @override
  State<HomePageChat> createState() => _HomePageChatState();
}

class _HomePageChatState extends State<HomePageChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatrooms")
                  .where("users", arrayContains: widget.userModel.uid)
                  .orderBy('createdon', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot chatRoomSnapshot =
                        snapshot.data as QuerySnapshot;

                    return ListView.builder(
                      itemCount: chatRoomSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                            chatRoomSnapshot.docs[index].data()
                                as Map<String, dynamic>);

                        Map<String, dynamic> participants =
                            chatRoomModel.participants!;

                        List<String> participantsKeys =
                            participants.keys.toList();

                        // participants.remove(widget.userModel.uid);

                        return FutureBuilder(
                          future: FirebaseHelper.getUserModelById(
                              participantsKeys[0]),
                          builder: (context, userData) {
                            if (userData.connectionState ==
                                ConnectionState.done) {
                              if (userData.data != null) {
                                UserModel targetUser =
                                    userData.data as UserModel;

                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatRoomPage(
                                                  chatroom: chatRoomModel,
                                                  targetUser: targetUser,
                                                  firebaseUser:
                                                      widget.firebaseUser,
                                                  userModel: widget.userModel,
                                                )));
                                  },
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          targetUser.profilepic.toString())),
                                  title: Text(targetUser.fullname.toString()),
                                  subtitle: Text(
                                      chatRoomModel.lastMessage.toString()),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: Text('no chats'),
                    );
                  }
                } else {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchPage(
                        userModel: widget.userModel,
                        firebaseUser: widget.firebaseUser,
                      )));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
