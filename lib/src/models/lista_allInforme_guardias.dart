
// To parse this JSON data, do
//
//     final allInformesGuardias = allInformesGuardiasFromMap(jsonString);

import 'dart:convert';

class AllInformesGuardias {
    AllInformesGuardias({
        required this.data,
    });

    List<Informe> data;

    factory AllInformesGuardias.fromJson(String str) => AllInformesGuardias.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllInformesGuardias.fromMap(Map<String, dynamic> json) => AllInformesGuardias(
        data: List<Informe>.from(json["data"].map((x) => Informe.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Informe {
    Informe({
        this.infId,
        this.infIdDirigido,
        this.infDocNumDirigido,
        this.infNomDirigido,
        this.infCorreo,
        this.infAsunto,
        this.infTipoNovedad,
        this.infFechaSuceso,
        this.infLugar,
        this.infPerjudicado,
        this.infPorque,
        this.infSucedido,
        this.infGuardias,
        this.infFotos,
        this.infVideo,
        this.infUser,
        this.infEmpresa,
        this.infFecReg,
        this.todos,
    });

    int? infId;
    String? infIdDirigido;
    String? infDocNumDirigido;
    String? infNomDirigido;
    List<String>? infCorreo;
    String? infAsunto;
    String? infTipoNovedad;
    String? infFechaSuceso;
    String? infLugar;
    String? infPerjudicado;
    String? infPorque;
    String? infSucedido;
    List<InfGuardia>? infGuardias;
    List<dynamic>? infFotos;
    List<dynamic>? infVideo;
    String? infUser;
    String? infEmpresa;
    DateTime? infFecReg;
    String? todos;

    factory Informe.fromJson(String str) => Informe.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Informe.fromMap(Map<String, dynamic> json) => Informe(
        infId: json["infId"],
        infIdDirigido: json["infIdDirigido"],
        infDocNumDirigido: json["infDocNumDirigido"],
        infNomDirigido: json["infNomDirigido"],
        infCorreo: List<String>.from(json["infCorreo"].map((x) => x)),
        infAsunto: json["infAsunto"],
        infTipoNovedad: json["infTipoNovedad"],
        infFechaSuceso: json["infFechaSuceso"],
        infLugar: json["infLugar"],
        infPerjudicado: json["infPerjudicado"],
        infPorque: json["infPorque"],
        infSucedido: json["infSucedido"],
        infGuardias: List<InfGuardia>.from(json["infGuardias"].map((x) => InfGuardia.fromMap(x))),
        infFotos: List<dynamic>.from(json["infFotos"].map((x) => x)),
        infVideo: List<dynamic>.from(json["infVideo"].map((x) => x)),
        infUser: json["infUser"],
        infEmpresa: json["infEmpresa"],
        infFecReg: DateTime.parse(json["infFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "infId": infId,
        "infIdDirigido": infIdDirigido,
        "infDocNumDirigido": infDocNumDirigido,
        "infNomDirigido": infNomDirigido,
        "infCorreo": List<dynamic>.from(infCorreo!.map((x) => x)),
        "infAsunto": infAsunto,
        "infTipoNovedad": infTipoNovedad,
        "infFechaSuceso": infFechaSuceso,
        "infLugar": infLugar,
        "infPerjudicado": infPerjudicado,
        "infPorque": infPorque,
        "infSucedido": infSucedido,
        "infGuardias": List<dynamic>.from(infGuardias!.map((x) => x.toMap())),
        "infFotos": List<dynamic>.from(infFotos!.map((x) => x)),
        "infVideo": List<dynamic>.from(infVideo!.map((x) => x)),
        "infUser": infUser,
        "infEmpresa": infEmpresa,
        "infFecReg": infFecReg.toString(),
        "Todos": todos,
    };
}

class InfGuardia {
    InfGuardia({
        this.perPuestoServicio,
        this.docnumero,
        this.nombres,
        this.asignado,
        this.id,
        this.foto,
        this.correo,
    });

    List<PerPuestoServicio>? perPuestoServicio;
    String? docnumero;
    String? nombres;
    bool? asignado;
    int? id;
    String? foto;
    List<String>? correo;

    factory InfGuardia.fromJson(String str) => InfGuardia.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InfGuardia.fromMap(Map<String, dynamic> json) => InfGuardia(
        perPuestoServicio: List<PerPuestoServicio>.from(json["perPuestoServicio"].map((x) => PerPuestoServicio.fromMap(x))),
        docnumero: json["docnumero"],
        nombres: json["nombres"],
        asignado: json["asignado"],
        id: json["id"],
        foto: json["foto"],
        correo: List<String>.from(json["correo"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "perPuestoServicio": List<dynamic>.from(perPuestoServicio!.map((x) => x.toMap())),
        "docnumero": docnumero,
        "nombres": nombres,
        "asignado": asignado,
        "id": id,
        "foto": foto,
        "correo": List<dynamic>.from(correo!.map((x) => x)),
    };
}

class PerPuestoServicio {
    PerPuestoServicio({
        this.ruccliente,
        this.razonsocial,
        this.ubicacion,
        this.puesto,
    });

    String? ruccliente;
    String? razonsocial;
    String? ubicacion;
    String? puesto;

    factory PerPuestoServicio.fromJson(String str) => PerPuestoServicio.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PerPuestoServicio.fromMap(Map<String, dynamic> json) => PerPuestoServicio(
        ruccliente: json["ruccliente"],
        razonsocial: json["razonsocial"],
        ubicacion: json["ubicacion"],
        puesto: json["puesto"],
    );

    Map<String, dynamic> toMap() => {
        "ruccliente": ruccliente,
        "razonsocial": razonsocial,
        "ubicacion": ubicacion,
        "puesto": puesto,
    };
}





