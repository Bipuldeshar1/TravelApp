class ReviewModel {
  String review;
  String description;
  String price;
  String sEmail;
  String sName;
  String sid;
  String title;
  String uemail;
  String uid;

  ReviewModel({
    required this.review,
    required this.description,
    required this.price,
    required this.sEmail,
    required this.sName,
    required this.sid,
    required this.title,
    required this.uemail,
    required this.uid,
  });
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      review: json['review'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      sEmail: json['sEmail'] ?? '',
      sName: json['sName'] ?? '',
      sid: json['sid'] ?? '',
      title: json['title'] ?? '',
      uemail: json['uemail'] ?? '',
      uid: json['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'description': description,
      'price': price,
      'sEmail': sEmail,
      'sName': sName,
      'sid': sid,
      'title': title,
      'uemail': uemail,
      'uid': uid,
    };
  }
}
