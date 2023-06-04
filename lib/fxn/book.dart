import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';

class Books {
  void book(
    String uid,
    String uname,
    String? uemail,
    int date,
    String pId,
    String title,
    String description,
    String img,
    int price,
    String? sid,
    String? sEmail,
    String pnum,
  ) {
    final date = DateTime.now();
    String text = 'pending';
    var id = Uuid().v1();
    try {
      FirebaseFirestore.instance.collection('orders').doc(id.toString()).set({
        'id': id,
        'uId': uid,
        'uName': uname,
        'uEmial': uemail,
        'bookingDate': date,
        'pId': pId,
        'ptitle': title,
        'pdescription': description,
        'pimg': img,
        'price': price,
        'sid': sid,
        'sEmail': sEmail,
        'pnum': pnum,
        'status': text,
      });
    } catch (e) {
      print(e);
    }
  }
}
