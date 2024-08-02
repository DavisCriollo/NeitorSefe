// To parse this JSON data, do
//
//     final allConsignasClientes = allConsignasClientesFromMap(jsonString);

import 'dart:convert';

class AllConsignasClientes {
    AllConsignasClientes({
        required this.data,
    });

    Data data;

    factory AllConsignasClientes.fromJson(String str) => AllConsignasClientes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllConsignasClientes.fromMap(Map<String, dynamic> json) => AllConsignasClientes(
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data.toMap(),
    };
}

class Data {
    Data({
       required this.results,
       required this.pagination,
    });

    List<Result> results;
    Pagination pagination;

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        pagination: Pagination.fromMap(json["pagination"]),
    );

    Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "pagination": pagination.toMap(),
    };
}

class Pagination {
    Pagination({
        this.current,
        this.perPage,
        this.numRows,
    });

    int? current;
    int? perPage;
    int? numRows;

    factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        current: json["current"],
        perPage: json["perPage"],
        numRows: json["numRows"],
    );

    Map<String, dynamic> toMap() => {
        "current": current,
        "perPage": perPage,
        "numRows": numRows,
    };
}

class Result {
    Result({
        this.conId,
        this.conIdCliente,
        this.conNombreCliente,
        this.conAsunto,
        this.conDetalle,
        this.conDesde,
        this.conHasta,
        this.conFrecuencia,
        this.conPrioridad,
        this.conEstado,
        this.conProgreso,
        this.conFotosCliente,
        this.conLeidos,
        this.conDiasRepetir,
        this.conAsignacion,
        this.conUser,
        this.conEmpresa,
        this.conFecReg,
        this.todos,
    });

    int? conId;
    String? conIdCliente;
    String? conNombreCliente;
    String? conAsunto;
    String? conDetalle;
    String? conDesde;
    String? conHasta;
    String? conFrecuencia;
    String? conPrioridad;
    String? conEstado;
    String? conProgreso;
    List<ConFotosCliente>? conFotosCliente;
    List<dynamic>? conLeidos;
    List<String>? conDiasRepetir;
    List<ConAsignacion>? conAsignacion;
    String? conUser;
    String? conEmpresa;
    DateTime? conFecReg;
    String? todos;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        conId: json["conId"],
        conIdCliente: json["conIdCliente"],
        conNombreCliente: json["conNombreCliente"],
        conAsunto: json["conAsunto"],
        conDetalle: json["conDetalle"],
        conDesde: json["conDesde"],
        conHasta: json["conHasta"],
        conFrecuencia: json["conFrecuencia"],
        conPrioridad: json["conPrioridad"],
        conEstado: json["conEstado"],
        conProgreso: json["conProgreso"],
        conFotosCliente: json["conFotosCliente"] == null ? null : List<ConFotosCliente>.from(json["conFotosCliente"].map((x) => ConFotosCliente.fromMap(x))),
        conLeidos: List<dynamic>.from(json["conLeidos"].map((x) => x)),
        conDiasRepetir: List<String>.from(json["conDiasRepetir"].map((x) => x)),
        conAsignacion: List<ConAsignacion>.from(json["conAsignacion"].map((x) => ConAsignacion.fromMap(x))),
        conUser: json["conUser"],
        conEmpresa: json["conEmpresa"],
        conFecReg: DateTime.parse(json["conFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "conId": conId,
        "conIdCliente": conIdCliente,
        "conNombreCliente": conNombreCliente,
        "conAsunto": conAsunto,
        "conDetalle": conDetalle,
        "conDesde": conDesde,
        "conHasta": conHasta,
        "conFrecuencia": conFrecuencia,
        "conPrioridad": conPrioridad,
        "conEstado": conEstado,
        "conProgreso": conProgreso,
        "conFotosCliente": conFotosCliente == null ? null : List<dynamic>.from(conFotosCliente!.map((x) => x.toMap())),
        "conLeidos": List<dynamic>.from(conLeidos!.map((x) => x)),
        "conDiasRepetir": List<dynamic>.from(conDiasRepetir!.map((x) => x)),
        "conAsignacion": List<dynamic>.from(conAsignacion!.map((x) => x.toMap())),
        "conUser": conUser,
        "conEmpresa": conEmpresa,
        "conFecReg": conFecReg.toString(),
        "Todos": todos,
    };
}

class ConAsignacion {
    ConAsignacion({
        this.docnumero,
        this.nombres,
        this.asignado,
        this.id,
        this.foto,
        this.trabajos,
    });

    String? docnumero;
    String? nombres;
    bool? asignado;
    int? id;
    String? foto;
    List<dynamic>? trabajos;

    factory ConAsignacion.fromJson(String str) => ConAsignacion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ConAsignacion.fromMap(Map<String, dynamic> json) => ConAsignacion(
        docnumero: json["docnumero"],
        nombres: json["nombres"],
        asignado: json["asignado"],
        id: json["id"],
        foto: json["foto"],
        trabajos: json["trabajos"] == null ? null : List<dynamic>.from(json["trabajos"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "docnumero": docnumero,
        "nombres": nombres,
        "asignado": asignado,
        "id": id,
        "foto": foto,
        "trabajos": trabajos == null ? null : List<dynamic>.from(trabajos!.map((x) => x)),
    };
}

class ConFotosCliente {
    ConFotosCliente({
        required this.nombre,
       required this.url,
    });

    String nombre;
    String url;

    factory ConFotosCliente.fromJson(String str) => ConFotosCliente.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ConFotosCliente.fromMap(Map<String, dynamic> json) => ConFotosCliente(
        nombre: json["nombre"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "url": url,
    };
}
