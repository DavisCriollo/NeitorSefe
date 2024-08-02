// // To parse this JSON data, do
// //
// //     final rondaSupervisoresModel = rondaSupervisoresModelFromMap(jsonString);

// import 'dart:convert';

// class RondaSupervisoresModel {
//     RondaSupervisoresModel({
//         required this.actSupervisores,
//     });

//     List<ActSupervisore> actSupervisores;

//     factory RondaSupervisoresModel.fromJson(String str) => RondaSupervisoresModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory RondaSupervisoresModel.fromMap(Map<String, dynamic> json) => RondaSupervisoresModel(
//         actSupervisores: List<ActSupervisore>.from(json["actSupervisores"].map((x) => ActSupervisore.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "actSupervisores": List<dynamic>.from(actSupervisores.map((x) => x.toMap())),
//     };
// }

// class ActSupervisore {
//     ActSupervisore({
//         this.docnumero,
//         this.nombres,
//         this.asignado,
//         this.id,
//         this.foto,
//         this.trabajos,
//     });

//     String? docnumero;
//     String? nombres;
//     bool? asignado;
//     int? id;
//     String? foto;
//     Trabajos? trabajos;

//     factory ActSupervisore.fromJson(String str) => ActSupervisore.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory ActSupervisore.fromMap(Map<String, dynamic> json) => ActSupervisore(
//         docnumero: json["docnumero"],
//         nombres: json["nombres"],
//         asignado: json["asignado"],
//         id: json["id"],
//         foto: json["foto"],
//         trabajos: Trabajos.fromMap(json["trabajos"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "docnumero": docnumero,
//         "nombres": nombres,
//         "asignado": asignado,
//         "id": id,
//         "foto": foto,
//         "trabajos": trabajos!.toMap(),
//     };
// }

// class Trabajos {
//     Trabajos({
//         required this.ronda,
//     });

//     List<Ronda> ronda;

//     factory Trabajos.fromJson(String str) => Trabajos.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Trabajos.fromMap(Map<String, dynamic> json) => Trabajos(
//         ronda: List<Ronda>.from(json["ronda"].map((x) => Ronda.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "ronda": List<dynamic>.from(ronda.map((x) => x.toMap())),
//     };
// }

// class Ronda {
//     Ronda({
//         this.nombre,
//         this.detalle,
//         this.fotos,
//         this.video,
//         this.qr,
//         this.fecha,
//     });

//     String? nombre;
//     String? detalle;
//     List<Foto>? fotos;
//     String? video;
//     String? qr;
//     String? fecha;

//     factory Ronda.fromJson(String str) => Ronda.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Ronda.fromMap(Map<String, dynamic> json) => Ronda(
//         nombre: json["nombre"],
//         detalle: json["detalle"],
//         fotos: List<Foto>.from(json["fotos"].map((x) => Foto.fromMap(x))),
//         video: json["video"],
//         qr: json["qr"],
//         fecha: json["fecha"],
//     );

//     Map<String, dynamic> toMap() => {
//         "nombre": nombre,
//         "detalle": detalle,
//         "fotos": List<dynamic>.from(fotos!.map((x) => x.toMap())),
//         "video": video,
//         "qr": qr,
//         "fecha": fecha,
//     };
// }

// class Foto {
//     Foto({
//         this.nombre,
//         this.url,
//     });

//     String? nombre;
//     String? url;

//     factory Foto.fromJson(String str) => Foto.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Foto.fromMap(Map<String, dynamic> json) => Foto(
//         nombre: json["nombre"],
//         url: json["url"],
//     );

//     Map<String, dynamic> toMap() => {
//         "nombre": nombre,
//         "url": url,
//     };
// }
