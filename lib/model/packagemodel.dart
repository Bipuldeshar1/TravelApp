import 'package:json_annotation/json_annotation.dart';
part 'packagemodel.g.dart';

@JsonSerializable(explicitToJson: true)
class PackageModel {
  String id;
  String title;
  String description;
  String img;
  int? rating;
  String price;
  bool? fav;
  

  PackageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
    this.rating,
    required this.price,
    this.fav,
  
  });
  factory PackageModel.fromJson(Map<String, dynamic> data) =>
      _$PackageModelFromJson(data);

  Map<String, dynamic> toJson() => _$PackageModelToJson(this);
}
