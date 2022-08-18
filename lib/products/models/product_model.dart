import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String pname;
  final double prix;
  final String categorie;
  final String ville;
  final String telephone;
  final String name;
  final String email;
  final String? whatsApp;
  final String description;
  final List<String> imgUrls;
  final DateTime addDate;
  ProductModel({
    required this.pname,
    required this.prix,
    required this.categorie,
    required this.ville,
    required this.telephone,
    required this.name,
    required this.email,
    this.whatsApp,
    required this.description,
    required this.imgUrls,
    required this.addDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Connect the generated [_$ProductModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
