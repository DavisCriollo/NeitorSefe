// // To parse this JSON data, do
// //
// //     final rondasActividad = rondasActividadFromMap(jsonString);

// import 'dart:convert';

// class RondasActividad {
//     RondasActividad({
//         this.nombre,
//         this.detalle,
//         this.fotos,
//         this.video,
//         this.qr,
//         this.fecha,
//     });

//     String? nombre;
//     String? detalle;
//     List<dynamic>? fotos;
//     String? video;
//     String? qr;
//     String? fecha;

//     factory RondasActividad.fromJson(String str) => RondasActividad.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory RondasActividad.fromMap(Map<String, dynamic> json) => RondasActividad(
//         nombre: json["nombre"],
//         detalle: json["detalle"],
//         fotos: List<dynamic>.from(json["fotos"].map((x) => x)),
//         video: json["video"],
//         qr: json["qr"],
//         fecha: json["fecha"],
//     );

//     Map<String, dynamic> toMap() => {
//         "nombre": nombre,
//         "detalle": detalle,
//         "fotos": List<dynamic>.from(fotos!.map((x) => x)),
//         "video": video,
//         "qr": qr,
//         "fecha": fecha,
//     };
// }

