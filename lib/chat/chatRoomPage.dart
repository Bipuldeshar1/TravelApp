import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/main.dart';
import 'package:project_3/model/chatRoomModel.dart';
import 'package:project_3/model/messageModel.dart';
import 'package:project_3/model/userModel.dart';

class ChatRoomPage extends StatefulWidget {
  UserModel targetUser;
  final ChatRoomModel chatroom;
  User firebaseUser;
  UserModel userModel;
  ChatRoomPage({
    required this.chatroom,
    required this.targetUser,
    required this.firebaseUser,
    required this.userModel,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final messageController = TextEditingController();

  sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != "") {
      //send msg
      MessageModel newMessage = MessageModel(
        messageid: uuid.v1(),
        sender: widget.userModel.uid,
        createdon: DateTime.now(),
        text: msg,
        seen: false,
      );
      //stores inside colection
      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomid)
          .collection('messages')
          .doc(newMessage.messageid)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = msg;
      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomid)
          .set(widget.chatroom.toMap());

      print('msg sent');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.targetUser.profilepic.toString()),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.targetUser.fullname.toString()),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(8),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chatrooms')
                      .doc(widget.chatroom.chatroomid)
                      .collection('messages')
                      .orderBy('createdon', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;
                        return ListView.builder(
                          reverse: true,
                          itemCount: dataSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromMap(
                                dataSnapshot.docs[index].data()
                                    as Map<String, dynamic>);
                            return Row(
                              mainAxisAlignment: (currentMessage.sender ==
                                      widget.userModel.uid)
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: (currentMessage.sender ==
                                              widget.userModel.uid)
                                          ? Colors.grey
                                          : Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      return Container(
                                        constraints: BoxConstraints(
                                            maxWidth:
                                                150 // Set maximum width based on parent constraints
                                            ),
                                        child: Text(
                                          currentMessage.text.toString(),
                                          maxLines:
                                              null, // Allow unlimited lines
                                          softWrap: true, // Enable wrapping
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('errroe'),
                        );
                      } else {
                        return Center(
                          child: Text('say hi'),
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: messageController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'msg',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: Icon(
                            Icons.send,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
