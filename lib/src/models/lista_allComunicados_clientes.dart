import 'dart:convert';

class AllCumunicadosClientes {
    AllCumunicadosClientes({
        required this.data,
    });

    Data data;

    factory AllCumunicadosClientes.fromJson(String str) => AllCumunicadosClientes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllCumunicadosClientes.fromMap(Map<String, dynamic> json) => AllCumunicadosClientes(
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
        this.comId,
        this.comClienteId,
        this.comClienteNombre,
        this.comAsunto,
        this.comDetalle,
        this.comEstado,
        this.comLeidos,
        this.comFotos,
        this.comEmpresa,
        this.comUser,
        this.comFecReg,
        this.todos,
    });

    int? comId;
    String? comClienteId;
    String? comClienteNombre;
    String? comAsunto;
    String? comDetalle;
    String? comEstado;
    List<dynamic>? comLeidos;
    List<dynamic>? comFotos;
    String? comEmpresa;
    String? comUser;
    DateTime? comFecReg;
    String? todos;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        comId: json["comId"],
        comClienteId: json["comClienteId"],
        comClienteNombre: json["comClienteNombre"],
        comAsunto: json["comAsunto"],
        comDetalle: json["comDetalle"],
        comEstado: json["comEstado"],
        comLeidos: List<dynamic>.from(json["comLeidos"].map((x) => x)),
        comFotos: List<dynamic>.from(json["comFotos"].map((x) => x)),
        comEmpresa: json["comEmpresa"],
        comUser: json["comUser"],
        comFecReg: DateTime.parse(json["comFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "comId": comId,
        "comClienteId": comClienteId,
        "comClienteNombre": comClienteNombre,
        "comAsunto": comAsunto,
        "comDetalle": comDetalle,
        "comEstado": comEstado,
        "comLeidos": List<dynamic>.from(comLeidos!.map((x) => x)),
        "comFotos": List<dynamic>.from(comFotos!.map((x) => x)),
        "comEmpresa": comEmpresa,
        "comUser": comUser,
        "comFecReg": comFecReg.toString(),
        "Todos": todos,
    };
}

