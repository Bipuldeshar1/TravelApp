import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';

class Books {
  String pnumb = '';
  Future<void> getNum() async {
    final x = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (x.exists) {
      final data = x.data();
      pnumb = data!['pnum'] ?? "";
    }
  }

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
    var id = const Uuid().v1();
    try {
      FirebaseFirestore.instance.collection('orders').doc(id.toString()).set({
        'id': id,
        'uId': uid,
        'uName': uname,
        'uEmail': FirebaseAuth.instance.currentUser!.email,
        'bookingDate': date,
        'pId': pId,
        'ptitle': title,
        'pdescription': description,
        'pimg': img,
        'price': price,
        'sid': sid,
        'sEmail': sEmail,
        'pnum': pnumb,
        'status': text,
      }).then((value) => storenotification(
          uid, uname, pId, title, description, img, price, sid, sEmail, pnumb));
    } catch (e) {
      print(e);
    }
  }

  storenotification(
    String uid,
    String uname,
    String pId,
    String title,
    String description,
    String img,
    int price,
    String? sid,
    String? sEmail,
    String pnum,
  ) {
    String msg = ' New Booking ';
    var date = DateTime.now();
    try {
      FirebaseFirestore.instance.collection('Order_notification').doc().set({
        //'id': package.id,
        'msg': msg,
        'nDate': date,
        'bookingDate': date,
        'pId': pId,
        'pdescription': description,
        'pimg': img,
        'pnum': pnum,
        'price': price,
        'ptitle': title,
        'sEmail': sEmail,
        'sid': sid,
        'uId': uid,
        'uName': uname,
        'uEmail': FirebaseAuth.instance.currentUser!.email,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
