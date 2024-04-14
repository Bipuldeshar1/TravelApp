import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/chat/chatRoomPage.dart';
import 'package:project_3/main.dart';
import 'package:project_3/model/chatRoomModel.dart';
import 'package:project_3/model/userModel.dart';

class SearchPage extends StatefulWidget {
  UserModel userModel;
  User firebaseUser;
  SearchPage({super.key, 
    required this.userModel,
    required this.firebaseUser,
  });
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${widget.userModel.uid}', isEqualTo: true)
        .where('participants.${targetUser.uid}', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      //fetch the existing one
      print('already created chatroom');
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatroom;
    } else {
      //create new
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        createdon: DateTime.now(),
        users: [
          widget.userModel.uid.toString(),
          targetUser.uid.toString(),
        ],
      );
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());
      chatRoom = newChatroom;
      print('chatroom created');
    }
    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('search'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(labelText: "Email Address"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text("Search"),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: searchController.text)
                        .where('email', isNotEqualTo: widget.userModel.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;

                          if (dataSnapshot.docs.isNotEmpty) {
                            Map<String, dynamic> userMap = dataSnapshot.docs[0]
                                .data() as Map<String, dynamic>;
                            UserModel searchedUser = UserModel.fromMap(userMap);

                            return ListTile(
                              onTap: () async {
                                ChatRoomModel? chatRoomModel =
                                    await getChatRoomModel(searchedUser);
                                if (chatRoomModel != null) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatRoomPage(
                                                chatroom: chatRoomModel,
                                                targetUser: searchedUser,
                                                firebaseUser:
                                                    widget.firebaseUser,
                                                userModel: widget.userModel,
                                              )));
                                }
                              },
                              leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(searchedUser.profilepic!)),
                              title: Text(searchedUser.fullname.toString()),
                              subtitle: Text(searchedUser.email.toString()),
                              trailing: const Icon(Icons.arrow_right),
                            );
                          } else {
                            return const Text('no result found');
                          }
                        } else if (snapshot.hasError) {
                          return const Text('errroe');
                        } else {
                          return const Text('no result found');
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
