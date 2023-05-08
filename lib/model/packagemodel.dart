class PackageModel {
  String pId;
  String title;
  String description;
  String img;
  int? rating;
  String price;
  bool? fav;

  PackageModel({
    required this.pId,
    required this.title,
    required this.description,
    required this.img,
    this.rating,
    required this.price,
    this.fav,
  });

  factory PackageModel.fromJson(Map<String, dynamic> map) {
    return PackageModel(
      pId: map['pId']??'',
      title: map['title']??'',
      description: map['description']??'',
      img: map['img']??'',
      rating: map['rating'],
      price: map['price'],
      fav: map['fav'],
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
    };
  }
}
