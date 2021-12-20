// To parse this JSON data, do
//
//     final tipoInmuebleModel = tipoInmuebleModelFromJson(jsonString);

import 'dart:convert';

TipoInmuebleModel tipoInmuebleModelFromJson(String str) =>
    TipoInmuebleModel.fromJson(json.decode(str));

String tipoInmuebleModelToJson(TipoInmuebleModel data) =>
    json.encode(data.toJson());

class TipoInmuebleModel {
  TipoInmuebleModel({
    this.id,
    this.nombre,
  });

  String id;
  String nombre = '';

  factory TipoInmuebleModel.fromJson(Map<String, dynamic> json) =>
      TipoInmuebleModel(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
