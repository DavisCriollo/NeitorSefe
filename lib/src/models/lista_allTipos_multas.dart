// To parse this JSON data, do
//
//     final allTiposMultasGuardias = allTiposMultasGuardiasFromMap(jsonString);

import 'dart:convert';

class AllTiposMultasGuardias {
    AllTiposMultasGuardias({
        required this.data,
    });

    List<TipoMulta> data;

    factory AllTiposMultasGuardias.fromJson(String str) => AllTiposMultasGuardias.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllTiposMultasGuardias.fromMap(Map<String, dynamic> json) => AllTiposMultasGuardias(
        data: List<TipoMulta>.from(json["data"].map((x) => TipoMulta.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class TipoMulta {
    TipoMulta({
        this.novId,
        this.novOrigen,
        this.novTipo,
        this.novPorcentaje,
        this.novlista,
        this.novUser,
        this.novEmpresa,
        this.novFecReg,
        this.todos,
    });
 bool isExpanded = false;
    int? novId;
    String? novOrigen;
    String? novTipo;
    String? novPorcentaje;
    List<ListaTipoMulta>? novlista;
    String? novUser;
    String? novEmpresa;
    DateTime? novFecReg;
    String? todos;

    factory TipoMulta.fromJson(String str) => TipoMulta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TipoMulta.fromMap(Map<String, dynamic> json) => TipoMulta(
        novId: json["novId"],
        novOrigen: json["novOrigen"],
        novTipo: json["novTipo"],
        novPorcentaje: json["novPorcentaje"],
        novlista: List<ListaTipoMulta>.from(json["novlista"].map((x) => ListaTipoMulta.fromMap(x))),
        novUser: json["novUser"],
        novEmpresa: json["novEmpresa"],
        novFecReg: DateTime.parse(json["novFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "novId": novId,
        "novOrigen": novOrigen,
        "novTipo": novTipo,
        "novPorcentaje": novPorcentaje,
        "novlista": List<dynamic>.from(novlista!.map((x) => x.toMap())),
        "novUser": novUser,
        "novEmpresa": novEmpresa,
        "novFecReg": novFecReg.toString(),
        "Todos": todos,
    };
}

class ListaTipoMulta {
    ListaTipoMulta({
        required this.nombre,
    });

    String nombre;

    factory ListaTipoMulta.fromJson(String str) => ListaTipoMulta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListaTipoMulta.fromMap(Map<String, dynamic> json) => ListaTipoMulta(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
    };
}
