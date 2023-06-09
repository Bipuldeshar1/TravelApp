class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  String? pnum;

  UserModel({this.uid, this.fullname, this.email, this.profilepic, this.pnum});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["name"];
    email = map["email"];
    profilepic = map["profilepic"];
    pnum = map["number"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
    };
  }
}
