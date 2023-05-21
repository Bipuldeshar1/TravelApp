class PackageModel {
  String pId;
  String title;
  String description;
  String img;
  List<double> ratings;
  String price;
  bool? fav;
  String? uId;
  String? uemail;
  String? x;
  String? y;
  String n;

  PackageModel({
    required this.pId,
    required this.title,
    required this.description,
    required this.img,
    this.ratings = const [],
    required this.price,
    this.fav,
    this.uId,
    this.uemail,
    this.x,
    this.y,
    required this.n,
  });

  factory PackageModel.fromJson(Map<String, dynamic> map) {
    final ratings = map['ratings'];
    List<double> parsedRatings = [];
    if (ratings is List) {
      parsedRatings = ratings.cast<double>();
    } else if (ratings is int) {
      parsedRatings = [ratings.toDouble()];
    }
    return PackageModel(
      pId: map['pId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      img: map['img'] ?? '',
      ratings: parsedRatings,
      price: map['price'].toString(),
      fav: map['fav'],
      uId: map['uId'],
      uemail: map['uemail'],
      x: map['lat'],
      y: map['lon'],
      n: map['n'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'pId': pId,
      'title': title,
      'description': description,
      'img': img,
      'ratings': ratings, // Include ratings in the JSON representation
      'price': price,
      'fav': fav,
      'uId': uId,
      'uemail': uemail,
      'lat': x,
      'lon': y,
      'n': n,
    };
  }
}
