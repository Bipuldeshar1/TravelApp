import 'package:cloud_firestore/cloud_firestore.dart';

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
    try {
      FirebaseFirestore.instance.collection('orders').doc().set({
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
        'pnum': pnum
      });
    } catch (e) {
      print(e);
    }
  }
}
