class Booking {
  String bookingDate;
  String pId;
  String pDescription;
  String pImg;
  int price;
  String pTitle;
  String sEmail;
  String sId;
  String uEmail;
  String uId;
  String uName;
  String pnum;

  Booking({
    required this.bookingDate,
    required this.pId,
    required this.pDescription,
    required this.pImg,
    required this.price,
    required this.pTitle,
    required this.sEmail,
    required this.sId,
    required this.uEmail,
    required this.uId,
    required this.uName,
    required this.pnum,
  });

  factory Booking.fromJson(Map<String, dynamic> map) {
    return Booking(
      bookingDate: map['bookingDate'].toString(),
      pId: map['pId'] ?? '',
      pDescription: map['pdescription'] ?? '',
      pImg: map['pimg'] ?? '',
      price: map['price'] ?? 0,
      pTitle: map['ptitle'] ?? '',
      sEmail: map['sEmail'] ?? '',
      sId: map['sid'] ?? '',
      uEmail: map['uEmial'] ?? '',
      uId: map['uId'] ?? '',
      uName: map['uName'] ?? '',
      pnum: map['pnum'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingDate': bookingDate,
      'pId': pId,
      'pdescription': pDescription,
      'pimg': pImg,
      'price': price,
      'ptitle': pTitle,
      'sEmail': sEmail,
      'sid': sId,
      'uEmial': uEmail,
      'uId': uId,
      'uName': uName,
      'pnum': pnum,
    };
  }
}
