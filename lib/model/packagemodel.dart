import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  String? x;
  String? y;
  String n;

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
    this.x,
    this.y,
    required this.n,
  });

  factory PackageModel.fromJson(Map<String, dynamic> map) {
    return PackageModel(
      pId: map['pId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      img: map['img'] ?? '',
      rating: map['rating'],
      price: map['price'].toString(),
      fav: map['fav'],
      uId: map['uId'],
      uemail: map['uemail'],
      x: map['lat'],
      y: map['lon'],
      n: map['n'] ?? '',
    );
  }

  
}
