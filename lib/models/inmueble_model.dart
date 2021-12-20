// To parse this JSON data, do
//
//     final inmuebleModel = inmuebleModelFromJson(jsonString);

import 'dart:convert';

import 'package:formulario_4/models/publicacion_model.dart';

InmuebleModel inmuebleModelFromJson(String str) =>
    InmuebleModel.fromJson(json.decode(str));

String inmuebleModelToJson(InmuebleModel data) => json.encode(data.toJson());

class InmuebleModel {
  String id;
  int superficie;
  int ambientes;
  int habitaciones;
  int lavatorios;
  int antiguedad;
  bool cochera;
  bool mascotas;
  bool calefaccion;
  String fotoUrl;
  String tipoId;

  //Publicacion
  double precio;
  double precioExpensas;
  DateTime fechaPublicacion;
  String tipoContrato;
  List<String> listaFotosUrls;

  // PublicacionModel publicacion;

  InmuebleModel({
    this.id,
    this.superficie,
    this.ambientes,
    this.habitaciones,
    this.lavatorios,
    this.antiguedad,
    this.cochera = false,
    this.mascotas = false,
    this.calefaccion = false,
    this.fotoUrl,
    this.tipoId = '',
    this.precio,
    this.precioExpensas,
    this.fechaPublicacion,
    this.tipoContrato,
    this.listaFotosUrls,
    // this.publicacion,
  });

  factory InmuebleModel.fromJson(Map<String, dynamic> json) => InmuebleModel(
        id: json["id"],
        superficie: json["superficie"],
        ambientes: json["ambientes"],
        habitaciones: json["habitaciones"],
        lavatorios: json["lavatorios"],
        antiguedad: json["antiguedad"],
        cochera: json["cochera"],
        mascotas: json["mascotas"],
        calefaccion: json["calefaccion"],
        fotoUrl: json["fotoUrl"],
        tipoId: json["tipoId"],
        //Publicacion
        precio: json['precio'],
        precioExpensas: json['precioExpensas'],
        fechaPublicacion: json['fechaPublicacion'],
        tipoContrato: json['tipoContratoId'],
        // listaFotosUrls: List<String>.from(json["listaFotosUrls"].map((x) => x)),
        // publicacion: json["publicacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "superficie": superficie,
        "ambientes": ambientes,
        "habitaciones": habitaciones,
        "lavatorios": lavatorios,
        "antiguedad": antiguedad,
        "cochera": cochera,
        "mascotas": mascotas,
        "calefaccion": calefaccion,
        "tipoId": tipoId,
        "fotoUrl": fotoUrl,
        // "listaFotosUrls": List<String>.from(listaFotosUrls.map((x) => x)),
        // "publicacion": publicacion,
      };
}
