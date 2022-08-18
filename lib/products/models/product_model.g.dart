// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      pname: json['pname'] as String,
      prix: (json['prix'] as num).toDouble(),
      categorie: json['categorie'] as String,
      ville: json['ville'] as String,
      telephone: json['telephone'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      whatsApp: json['whatsApp'] as String?,
      description: json['description'] as String,
      imgUrls:
          (json['imgUrls'] as List<dynamic>).map((e) => e as String).toList(),
      addDate: DateTime.parse(json['addDate'] as String),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'pname': instance.pname,
      'prix': instance.prix,
      'categorie': instance.categorie,
      'ville': instance.ville,
      'telephone': instance.telephone,
      'name': instance.name,
      'email': instance.email,
      'whatsApp': instance.whatsApp,
      'description': instance.description,
      'imgUrls': instance.imgUrls,
      'addDate': instance.addDate.toIso8601String(),
    };
