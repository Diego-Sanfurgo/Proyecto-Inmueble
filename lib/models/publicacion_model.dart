// To parse this JSON data, do
//
//     final publicacionModel = publicacionModelFromJson(jsonString);

import 'dart:convert';

PublicacionModel publicacionModelFromJson(String str) =>
    PublicacionModel.fromJson(json.decode(str));

String publicacionModelToJson(PublicacionModel data) =>
    json.encode(data.toJson());

class PublicacionModel {
  PublicacionModel({
    this.id = '',
    this.precio = 0,
    this.precioExpensas = 0,
    this.fechaPublicacion,
    this.tipoContratoId,
  });

  String id;
  double precio;
  double precioExpensas;
  DateTime fechaPublicacion;
  String tipoContratoId;

  factory PublicacionModel.fromJson(Map<String, dynamic> json) =>
      PublicacionModel(
        id: json["id"],
        precio: json["precio"].toDouble(),
        precioExpensas: json["precioExpensas"].toDouble(),
        fechaPublicacion: json["fechaPublicacion"],
        tipoContratoId: json["contratoID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "precio": precio,
        "precioExpensas": precioExpensas,
        "fechaPublicacion": fechaPublicacion,
        "contratoID": tipoContratoId,
      };
}
