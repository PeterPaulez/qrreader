import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id,
    this.tipo,
    @required this.valor, // Importa META package para obligar con REQUIRED
  }) {
    // Hacemos obligatorio valor para marcar el tipo
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  int id;
  String tipo;
  String valor;

  // Especial model y solo mostramos LATLNG de googlemaps
  LatLng getLatLng() {
    final latLng = this.valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
