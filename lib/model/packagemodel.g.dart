// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packagemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageModel _$PackageModelFromJson(Map<String, dynamic> json) => PackageModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      img: json['img'] as String,
      rating: json['rating'] as int?,
      price: json['price'] as String,
      fav: json['fav'] as bool?,
    );

Map<String, dynamic> _$PackageModelToJson(PackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'img': instance.img,
      'rating': instance.rating,
      'price': instance.price,
      'fav': instance.fav,
    };
