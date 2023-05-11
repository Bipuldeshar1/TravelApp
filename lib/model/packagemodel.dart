class PackageModel {
  String pId;
  String title;
  String description;
  String img;
  int? rating;
  String price;
  bool? fav;
  String? uId;
  String? uemail;

  PackageModel({
    required this.pId,
    required this.title,
    required this.description,
    required this.img,
    this.rating,
    required this.price,
    this.fav,
    this.uId,
    this.uemail,
  });

  factory PackageModel.fromJson(Map<String, dynamic> map) {
    return PackageModel(
      pId: map['pId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      img: map['img'] ?? '',
      rating: map['rating'],
      price: map['price'],
      fav: map['fav'],
      uId: map['uId'],
      uemail: map['uemail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pid': pId,
      'title': title,
      'description': description,
      'img': img,
      'rating': rating,
      'price': price,
      'fav': fav,
      'uId': uId,
      'uemail': uemail,
    };
  }
}
