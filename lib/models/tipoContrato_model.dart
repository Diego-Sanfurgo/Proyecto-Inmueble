// To parse this JSON data, do
//
//     final tipoContratoModel = tipoContratoModelFromJson(jsonString);

import 'dart:convert';

TipoContratoModel tipoContratoModelFromJson(String str) =>
    TipoContratoModel.fromJson(json.decode(str));

String tipoContratoModelToJson(TipoContratoModel data) =>
    json.encode(data.toJson());

class TipoContratoModel {
  TipoContratoModel({
    this.id,
    this.nombre,
  });

  String id;
  String nombre;

  factory TipoContratoModel.fromJson(Map<String, dynamic> json) =>
      TipoContratoModel(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
