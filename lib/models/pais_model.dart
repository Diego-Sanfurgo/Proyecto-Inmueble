// To parse this JSON data, do
//
//     final paisModel = paisModelFromJson(jsonString);

import 'dart:convert';

PaisModel paisModelFromJson(String str) => PaisModel.fromJson(json.decode(str));

String paisModelToJson(PaisModel data) => json.encode(data.toJson());

class PaisModel {
  PaisModel({
    this.id,
    this.nombre,
  });

  String id;
  String nombre;

  factory PaisModel.fromJson(Map<String, dynamic> json) => PaisModel(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
