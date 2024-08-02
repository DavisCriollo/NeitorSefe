// To parse this JSON data, do
//
//     final allEstadosCuentaCliente = allEstadosCuentaClienteFromMap(jsonString);

import 'dart:convert';

class AllEstadosCuentaCliente {
    AllEstadosCuentaCliente({
        required this.data,
    });

    Data data;

    factory AllEstadosCuentaCliente.fromJson(String str) => AllEstadosCuentaCliente.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllEstadosCuentaCliente.fromMap(Map<String, dynamic> json) => AllEstadosCuentaCliente(
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
        required this.current,
        required this.perPage,
        required this.numRows,
    });

    int current;
    int perPage;
    int numRows;

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
        this.estId,
        this.estClienteId,
        this.estClienteDocu,
        this.estClienteNombre,
        this.estPeriodo,
        this.estFecInicio,
        this.estFecFinal,
        this.estFecAbono,
        this.estMonto,
        this.estAbono,
        this.estSaldo,
        this.estEstado,
        this.estAutomatico,
        this.estCuotas,
        this.estEmpresa,
        this.estUser,
        this.estFecReg,
        this.todos,
    });

    int? estId;
    String? estClienteId;
    String? estClienteDocu;
    String? estClienteNombre;
    String? estPeriodo;
    DateTime? estFecInicio;
    DateTime? estFecFinal;
    String? estFecAbono;
    String? estMonto;
    String? estAbono;
    String? estSaldo;
    String? estEstado;
    String? estAutomatico;
    List<EstCuota>? estCuotas;
    String? estEmpresa;
    String? estUser;
    DateTime? estFecReg;
    String? todos;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        estId: json["estId"],
        estClienteId: json["estClienteId"],
        estClienteDocu: json["estClienteDocu"],
        estClienteNombre: json["estClienteNombre"],
        estPeriodo: json["estPeriodo"],
        estFecInicio: DateTime.parse(json["estFecInicio"]),
        estFecFinal: DateTime.parse(json["estFecFinal"]),
        estFecAbono: json["estFecAbono"],
        estMonto: json["estMonto"],
        estAbono: json["estAbono"],
        estSaldo: json["estSaldo"],
        estEstado: json["estEstado"],
        estAutomatico: json["estAutomatico"],
        estCuotas: List<EstCuota>.from(json["estCuotas"].map((x) => EstCuota.fromMap(x))),
        estEmpresa: json["estEmpresa"],
        estUser: json["estUser"],
        estFecReg: DateTime.parse(json["estFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "estId": estId,
        "estClienteId": estClienteId,
        "estClienteDocu": estClienteDocu,
        "estClienteNombre": estClienteNombre,
        "estPeriodo": estPeriodo,
        "estFecInicio": "${estFecInicio!.year.toString().padLeft(4, '0')}-${estFecInicio!.month.toString().padLeft(2, '0')}-${estFecInicio!.day.toString().padLeft(2, '0')}",
        "estFecFinal": "${estFecFinal!.year.toString().padLeft(4, '0')}-${estFecFinal!.month.toString().padLeft(2, '0')}-${estFecFinal!.day.toString().padLeft(2, '0')}",
        "estFecAbono": estFecAbono,
        "estMonto": estMonto,
        "estAbono": estAbono,
        "estSaldo": estSaldo,
        "estEstado": estEstado,
        "estAutomatico": estAutomatico,
        "estCuotas": List<dynamic>.from(estCuotas!.map((x) => x.toMap())),
        "estEmpresa": estEmpresa,
        "estUser": estUser,
        "estFecReg": estFecReg.toString(),
        "Todos": todos,
    };
}

class EstCuota {
    EstCuota({
        this.detalle,
        this.fecha,
        this.cuota,
        this.estado,
        this.user,
    });

    String? detalle;
    DateTime? fecha;
    String? cuota;
    String? estado;
    String? user;

    factory EstCuota.fromJson(String str) => EstCuota.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EstCuota.fromMap(Map<String, dynamic> json) => EstCuota(
        detalle: json["detalle"],
        fecha: DateTime.parse(json["fecha"]),
        cuota: json["cuota"],
        estado: json["estado"],
        user: json["user"],
    );

    Map<String, dynamic> toMap() => {
        "detalle": detalle,
        "fecha": "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "cuota": cuota,
        "estado": estado,
        "user": user,
    };
}
