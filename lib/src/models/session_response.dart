

// import 'dart:convert';

// class Session {
//     Session({
//         this.token,
//         this.id,
//         this.nombre,
//         this.usuario,
//         this.rucempresa,
//         this.codigo,
//         this.nomEmpresa,
//         this.nomComercial,
//         this.fechaCaducaFirma,
//         this.rol,
//         this.tipografia,
//         this.logo,
//     });

//     String? token;
//     int? id;
//     String? nombre;
//     String? usuario;
//     String? rucempresa;
//     String? codigo;
//     String? nomEmpresa;
//     String? nomComercial;
//     DateTime? fechaCaducaFirma;
//     List<String>? rol;
//     String? tipografia;
//     String? logo;

//     factory Session.fromJson(String str) => Session.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Session.fromMap(Map<String, dynamic> json) => Session(
//         token: json["token"],
//         id: json["id"],
//         nombre: json["nombre"],
//         usuario: json["usuario"],
//         rucempresa: json["rucempresa"],
//         codigo: json["codigo"],
//         nomEmpresa: json["nomEmpresa"],
//         nomComercial: json["nomComercial"],
//         fechaCaducaFirma: DateTime.parse(json["fechaCaducaFirma"]),
//         rol: List<String>.from(json["rol"].map((x) => x)),
//         tipografia: json["tipografia"],
//         logo: json["logo"],
//     );

//     Map<String, dynamic> toMap() => {
//         "token": token,
//         "id": id,
//         "nombre": nombre,
//         "usuario": usuario,
//         "rucempresa": rucempresa,
//         "codigo": codigo,
//         "nomEmpresa": nomEmpresa,
//         "nomComercial": nomComercial,
//         "fechaCaducaFirma": "${fechaCaducaFirma!.year.toString().padLeft(4, '0')}-${fechaCaducaFirma!.month.toString().padLeft(2, '0')}-${fechaCaducaFirma!.day.toString().padLeft(2, '0')}",
//         "rol": List<dynamic>.from(rol!.map((x) => x)),
//         "tipografia": tipografia,
//         "logo": logo,
//     };
// }








// To parse this JSON data, do
//
//     final session = sessionFromMap(jsonString);

import 'dart:convert';

class Session {
    Session({
        this.token,
        this.id,
        this.nombre,
        this.usuario,
        this.rucempresa,
        this.codigo,
        this.nomEmpresa,
        this.nomComercial,
        this.fechaCaducaFirma,
        this.rol,
        this.tipografia,
        this.logo,
        this.areadepartamento,
        this.foto,
        this.empCategoria,
        this.colorPrimario,
        this.colorSecundario,
        this.regId,
    });

    String? token;
    int? id;
    String? nombre;
    String? usuario;
    String? rucempresa;
    String? codigo;
    String? nomEmpresa;
    String? nomComercial;
    DateTime? fechaCaducaFirma;
    List<String>? rol;
    String? tipografia;
    String? logo;
    String? areadepartamento;
    String? foto;
    String? empCategoria;
    String? colorPrimario;
    String? colorSecundario;
    String? regId;

    factory Session.fromJson(String str) => Session.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Session.fromMap(Map<String, dynamic> json) => Session(
        token: json["token"],
        id: json["id"],
        nombre: json["nombre"],
        usuario: json["usuario"],
        rucempresa: json["rucempresa"],
        codigo: json["codigo"],
        nomEmpresa: json["nomEmpresa"],
        nomComercial: json["nomComercial"],
        fechaCaducaFirma: DateTime.parse(json["fechaCaducaFirma"]),
        rol: List<String>.from(json["rol"].map((x) => x)),
        tipografia: json["tipografia"],
        logo: json["logo"],
        areadepartamento: json["areadepartamento"],
        foto: json["foto"],
        empCategoria: json["empCategoria"],
        colorPrimario: json["colorPrimario"],
        colorSecundario: json["colorSecundario"],
        regId: json["regId"],
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "id": id,
        "nombre": nombre,
        "usuario": usuario,
        "rucempresa": rucempresa,
        "codigo": codigo,
        "nomEmpresa": nomEmpresa,
        "nomComercial": nomComercial,
        "fechaCaducaFirma": "${fechaCaducaFirma!.year.toString().padLeft(4, '0')}-${fechaCaducaFirma!.month.toString().padLeft(2, '0')}-${fechaCaducaFirma!.day.toString().padLeft(2, '0')}",
        "rol": List<dynamic>.from(rol!.map((x) => x)),
        "tipografia": tipografia,
        "logo": logo,
        "areadepartamento": areadepartamento,
        "foto": foto,
        "empCategoria": empCategoria,
        "colorPrimario": colorPrimario,
        "colorSecundario": colorSecundario,
         "regId": regId,
    };
}
