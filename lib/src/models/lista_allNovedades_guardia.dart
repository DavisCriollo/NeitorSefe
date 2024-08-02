
// // To parse this JSON data, do
// //
// //     final allNovedadesGuardia = allNovedadesGuardiaFromMap(jsonString);

// import 'dart:convert';

// class AllNovedadesGuardia {
//     AllNovedadesGuardia({
//         required this.data,
//     });

//     List<Result> data;

//     factory AllNovedadesGuardia.fromJson(String str) => AllNovedadesGuardia.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory AllNovedadesGuardia.fromMap(Map<String, dynamic> json) => AllNovedadesGuardia(
//         data: List<Result>.from(json["data"].map((x) => Result.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//     };
// }

// class Result {
//     Result({
//         this.nomId,
//         this.nomCodigo,
//         this.nomOrigen,
//         this.nomTipo,
//         this.nomPorcentaje,
//         this.nomDetalle,
//         this.nomObservacion,
//         this.nomFotos,
//         this.nomVideo,
//         this.nomCompartido,
//         this.nomEstado,
//         this.nomAnulacion,
//         this.nomCiudad,
//         this.nomFecha,
//         this.nomIdPer,
//         this.nomDocuPer,
//         this.nomNombrePer,
//         this.nomUser,
//         this.nomEmpresa,
//         this.nomFecReg,
//         this.todos,
//     });

//     int? nomId;
//     String? nomCodigo;
//     String? nomOrigen;
//     String? nomTipo;
//     String? nomPorcentaje;
//     String? nomDetalle;
//     String? nomObservacion;
//     List<NomFoto>? nomFotos;
//     List<dynamic>? nomVideo;
//     List<NomCompartido>? nomCompartido;
//     String? nomEstado;
//     String? nomAnulacion;
//     String? nomCiudad;
//     DateTime? nomFecha;
//     String? nomIdPer;
//     String? nomDocuPer;
//     String? nomNombrePer;
//     String? nomUser;
//     String? nomEmpresa;
//     DateTime? nomFecReg;
//     String? todos;

//     factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Result.fromMap(Map<String, dynamic> json) => Result(
//         nomId: json["nomId"],
//         nomCodigo: json["nomCodigo"],
//         nomOrigen: json["nomOrigen"],
//         nomTipo: json["nomTipo"],
//         nomPorcentaje: json["nomPorcentaje"],
//         nomDetalle: json["nomDetalle"],
//         nomObservacion: json["nomObservacion"],
//         nomFotos: List<NomFoto>.from(json["nomFotos"].map((x) => NomFoto.fromMap(x))),
//         nomVideo: List<dynamic>.from(json["nomVideo"].map((x) => x)),
//         nomCompartido: List<NomCompartido>.from(json["nomCompartido"].map((x) => NomCompartido.fromMap(x))),
//         nomEstado: json["nomEstado"],
//         nomAnulacion: json["nomAnulacion"],
//         nomCiudad: json["nomCiudad"],
//         nomFecha: DateTime.parse(json["nomFecha"]),
//         nomIdPer: json["nomIdPer"],
//         nomDocuPer: json["nomDocuPer"],
//         nomNombrePer: json["nomNombrePer"],
//         nomUser: json["nomUser"],
//         nomEmpresa: json["nomEmpresa"],
//         nomFecReg: DateTime.parse(json["nomFecReg"]),
//         todos: json["Todos"],
//     );

//     Map<String, dynamic> toMap() => {
//         "nomId": nomId,
//         "nomCodigo": nomCodigo,
//         "nomOrigen": nomOrigen,
//         "nomTipo": nomTipo,
//         "nomPorcentaje": nomPorcentaje,
//         "nomDetalle": nomDetalle,
//         "nomObservacion": nomObservacion,
//         "nomFotos": List<dynamic>.from(nomFotos!.map((x) => x.toMap())),
//         "nomVideo": List<dynamic>.from(nomVideo!.map((x) => x)),
//         "nomCompartido": List<dynamic>.from(nomCompartido!.map((x) => x.toMap())),
//         "nomEstado": nomEstado,
//         "nomAnulacion": nomAnulacion,
//         "nomCiudad": nomCiudad,
//         "nomFecha": "${nomFecha!.year.toString().padLeft(4, '0')}-${nomFecha!.month.toString().padLeft(2, '0')}-${nomFecha!.day.toString().padLeft(2, '0')}",
//         "nomIdPer": nomIdPer,
//         "nomDocuPer": nomDocuPer,
//         "nomNombrePer": nomNombrePer,
//         "nomUser": nomUser,
//         "nomEmpresa": nomEmpresa,
//         "nomFecReg": nomFecReg.toString(),
//         "Todos": todos,
//     };
// }

// class NomCompartido {
//     NomCompartido({
//         this.id,
//         this.docnumero,
//         this.nombres,
//         this.compartido,
//         this.email,
//     });

//     int? id;
//     String? docnumero;
//     String? nombres;
//     bool? compartido;
//     List<String>? email;

//     factory NomCompartido.fromJson(String str) => NomCompartido.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory NomCompartido.fromMap(Map<String, dynamic> json) => NomCompartido(
//         id: json["id"],
//         docnumero: json["docnumero"],
//         nombres: json["nombres"],
//         compartido: json["compartido"],
//         email: List<String>.from(json["email"].map((x) => x)),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "docnumero": docnumero,
//         "nombres": nombres,
//         "compartido": compartido,
//         "email": List<dynamic>.from(email!.map((x) => x)),
//     };
// }

// class NomFoto {
//     NomFoto({
//         required this.nombre,
//         required this.url,
//     });

//     String nombre;
//     String url;

//     factory NomFoto.fromJson(String str) => NomFoto.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory NomFoto.fromMap(Map<String, dynamic> json) => NomFoto(
//         nombre: json["nombre"],
//         url: json["url"],
//     );

//     Map<String, dynamic> toMap() => {
//         "nombre": nombre,
//         "url": url,
//     };
// }


// To parse this JSON data, do
//
//     final allNovedadesGuardia = allNovedadesGuardiaFromMap(jsonString);

import 'dart:convert';

class AllNovedadesGuardia {
    AllNovedadesGuardia({
        required this.data,
    });

    List<Result> data;

    factory AllNovedadesGuardia.fromJson(String str) => AllNovedadesGuardia.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllNovedadesGuardia.fromMap(Map<String, dynamic> json) => AllNovedadesGuardia(
        data: List<Result>.from(json["data"].map((x) => Result.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Result {
    Result({
        this.nomId,
        this.nomCodigo,
        this.nomOrigen,
        this.nomTipo,
        this.nomPorcentaje,
        this.nomSueldo,
        this.nomDescuento,
        this.nomDetalle,
        this.nomObservacion,
        this.nomFotos,
        this.nomVideo,
        this.nomCompartido,
        this.nomPuesto,
        this.nomEstado,
        this.nomAnulacion,
        this.nomCiudad,
        this.nomFecha,
        this.nomIdPer,
        this.nomDocuPer,
        this.nomNombrePer,
        this.nomApelacionTexto,
        this.nomApelacionFotos,
        this.nomApelacionFecha,
        this.nomApelacionTextoAceptada,
        this.nomApelacionFechaAceptada,
        this.nomApelacionUserAceptada,
        this.nomCorreo,
        this.nomUser,
        this.nomEmpresa,
        this.nomFecReg,
        this.todos,
    });

    int? nomId;
    String? nomCodigo;
    String? nomOrigen;
    String? nomTipo;
    String? nomPorcentaje;
    String? nomSueldo;
    String? nomDescuento;
    String? nomDetalle;
    String? nomObservacion;
    List<NomFoto>? nomFotos;
    List<dynamic>? nomVideo;
    List<dynamic>? nomCompartido;
    List<dynamic>? nomPuesto;
    String? nomEstado;
    String? nomAnulacion;
    String? nomCiudad;
    DateTime? nomFecha;
    String? nomIdPer;
    String? nomDocuPer;
    String? nomNombrePer;
    String? nomApelacionTexto;
    List<dynamic>? nomApelacionFotos;
    List<dynamic>? nomCorreo;
    String? nomApelacionFecha;
    String? nomApelacionTextoAceptada;
    String? nomApelacionFechaAceptada;
    String? nomApelacionUserAceptada;
    String? nomUser;
    String? nomEmpresa;
    DateTime? nomFecReg;
    String? todos;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        nomId: json["nomId"],
        nomCodigo: json["nomCodigo"],
        nomOrigen: json["nomOrigen"],
        nomTipo: json["nomTipo"],
        nomPorcentaje: json["nomPorcentaje"],
        nomSueldo: json["nomSueldo"],
        nomDescuento: json["nomDescuento"],
        nomDetalle: json["nomDetalle"],
        nomObservacion: json["nomObservacion"],
        nomFotos: List<NomFoto>.from(json["nomFotos"].map((x) => NomFoto.fromMap(x))),
        nomVideo: List<dynamic>.from(json["nomVideo"].map((x) => x)),
        nomCompartido: List<dynamic>.from(json["nomCompartido"].map((x) => x)),
        nomPuesto: List<dynamic>.from(json["nomPuesto"].map((x) => x)),
        nomEstado: json["nomEstado"],
        nomAnulacion: json["nomAnulacion"],
        nomCiudad: json["nomCiudad"],
        nomFecha: DateTime.parse(json["nomFecha"]),
        nomIdPer: json["nomIdPer"],
        nomDocuPer: json["nomDocuPer"],
        nomNombrePer: json["nomNombrePer"],
        nomApelacionTexto: json["nomApelacionTexto"],
        nomApelacionFotos: List<dynamic>.from(json["nomApelacionFotos"].map((x) => x)),
        nomCorreo: List<dynamic>.from(json["nomCorreo"].map((x) => x)),
        nomApelacionFecha: json["nomApelacionFecha"],
        nomApelacionTextoAceptada: json["nomApelacionTextoAceptada"],
        nomApelacionFechaAceptada: json["nomApelacionFechaAceptada"],
        nomApelacionUserAceptada: json["nomApelacionUserAceptada"],
        nomUser: json["nomUser"],
        nomEmpresa: json["nomEmpresa"],
        nomFecReg: DateTime.parse(json["nomFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "nomId": nomId,
        "nomCodigo": nomCodigo,
        "nomOrigen": nomOrigen,
        "nomTipo": nomTipo,
        "nomPorcentaje": nomPorcentaje,
        "nomSueldo": nomSueldo,
        "nomDescuento": nomDescuento,
        "nomDetalle": nomDetalle,
        "nomObservacion": nomObservacion,
        "nomFotos": List<dynamic>.from(nomFotos!.map((x) => x.toMap())),
        "nomVideo": List<dynamic>.from(nomVideo!.map((x) => x)),
        "nomCompartido": List<dynamic>.from(nomCompartido!.map((x) => x)),
        "nomPuesto": List<dynamic>.from(nomPuesto!.map((x) => x)),
        "nomEstado": nomEstado,
        "nomAnulacion": nomAnulacion,
        "nomCiudad": nomCiudad,
        "nomFecha": "${nomFecha!.year.toString().padLeft(4, '0')}-${nomFecha!.month.toString().padLeft(2, '0')}-${nomFecha!.day.toString().padLeft(2, '0')}",
        "nomIdPer": nomIdPer,
        "nomDocuPer": nomDocuPer,
        "nomNombrePer": nomNombrePer,
        "nomApelacionTexto": nomApelacionTexto,
        "nomApelacionFotos": List<dynamic>.from(nomApelacionFotos!.map((x) => x)),
        "nomCorreo": List<dynamic>.from(nomCorreo!.map((x) => x)),
        "nomApelacionFecha": nomApelacionFecha,
        "nomApelacionTextoAceptada": nomApelacionTextoAceptada,
        "nomApelacionFechaAceptada": nomApelacionFechaAceptada,
        "nomApelacionUserAceptada": nomApelacionUserAceptada,
        "nomUser": nomUser,
        "nomEmpresa": nomEmpresa,
        "nomFecReg": nomFecReg.toString(),
        "Todos": todos,
    };
}

class NomFoto {
    NomFoto({
        this.nombre,
        this.url,
    });

    String? nombre;
    String? url;

    factory NomFoto.fromJson(String str) => NomFoto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NomFoto.fromMap(Map<String, dynamic> json) => NomFoto(
        nombre: json["nombre"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "url": url,
    };
}
