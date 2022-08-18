// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdressModel _$AdressModelFromJson(Map<String, dynamic> json) => AdressModel(
      ville: json['ville'] as String,
      telephone: json['telephone'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      whatsApp: json['whatsApp'] as String?,
    );

Map<String, dynamic> _$AdressModelToJson(AdressModel instance) =>
    <String, dynamic>{
      'ville': instance.ville,
      'telephone': instance.telephone,
      'name': instance.name,
      'email': instance.email,
      'whatsApp': instance.whatsApp,
    };
