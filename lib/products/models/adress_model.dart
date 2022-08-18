import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adress_model.g.dart';

@JsonSerializable()
class AdressModel {
  final String ville;
  final String telephone;
  final String name;
  final String email;
  final String? whatsApp;
  AdressModel({
    required this.ville,
    required this.telephone,
    required this.name,
    required this.email,
    this.whatsApp,
  });

  factory AdressModel.fromJson(Map<String, dynamic> json) =>
      _$AdressModelFromJson(json);

  /// Connect the generated [_$AdressModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AdressModelToJson(this);
}
