

import 'dart:convert';

class AllImplementoPedido {
    AllImplementoPedido({
        required this.data,
    });

    List<Implemento> data;

    factory AllImplementoPedido.fromJson(String str) => AllImplementoPedido.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllImplementoPedido.fromMap(Map<String, dynamic> json) => AllImplementoPedido(
        data: List<Implemento>.from(json["data"].map((x) => Implemento.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Implemento {
    Implemento({
        this.invId,
        this.invTipo,
        this.invSerie,
        this.invNombre,
        this.invPrecioUnitario,
        this.invProductoEstado,
        this.invMarca,
        this.invModelo,
        this.invStock,
        this.invDisponible,
        this.invTalla,
        this.invClase,
        this.invTipoArma,
        this.invCalibre,
        this.invColor,
        this.invUso,
        this.invStatus,
        this.invProveedor,
        this.invComprobantePdf,
        this.invPermisoPdf,
        this.invFecValidacion,
        this.invFecCaducidad,
        this.invEstado,
        this.invEmpresa,
        this.invUser,
        this.invFecReg,
        this.todos,
    });

    int? invId;
    String? invTipo;
    String? invSerie;
    String? invNombre;
    String? invPrecioUnitario;
    String? invProductoEstado;
    String? invMarca;
    String? invModelo;
    String? invStock;
    String? invDisponible;
    String? invTalla;
    String? invClase;
    String? invTipoArma;
    String? invCalibre;
    String? invColor;
    String? invUso;
    String? invStatus;
    List<InvProveedor>? invProveedor;
    String? invComprobantePdf;
    String? invPermisoPdf;
    String? invFecValidacion;
    String? invFecCaducidad;
    String? invEstado;
    String? invEmpresa;
    String? invUser;
    DateTime? invFecReg;
    String? todos;

    factory Implemento.fromJson(String str) => Implemento.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Implemento.fromMap(Map<String, dynamic> json) => Implemento(
        invId: json["invId"],
        invTipo: json["invTipo"],
        invSerie: json["invSerie"],
        invNombre: json["invNombre"],
        invPrecioUnitario: json["invPrecioUnitario"],
        invProductoEstado: json["invProductoEstado"],
        invMarca: json["invMarca"],
        invModelo: json["invModelo"],
        invStock: json["invStock"],
        invDisponible: json["invDisponible"],
        invTalla: json["invTalla"],
        invClase: json["invClase"],
        invTipoArma: json["invTipoArma"],
        invCalibre: json["invCalibre"],
        invColor: json["invColor"],
        invUso: json["invUso"],
        invStatus: json["invStatus"],
        invProveedor: List<InvProveedor>.from(json["invProveedor"].map((x) => InvProveedor.fromMap(x))),
        invComprobantePdf: json["invComprobantePdf"],
        invPermisoPdf: json["invPermisoPdf"],
        invFecValidacion: json["invFecValidacion"],
        invFecCaducidad: json["invFecCaducidad"],
        invEstado: json["invEstado"],
        invEmpresa: json["invEmpresa"],
        invUser: json["invUser"],
        invFecReg: DateTime.parse(json["invFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "invId": invId,
        "invTipo": invTipo,
        "invSerie": invSerie,
        "invNombre": invNombre,
        "invPrecioUnitario": invPrecioUnitario,
        "invProductoEstado": invProductoEstado,
        "invMarca": invMarca,
        "invModelo": invModelo,
        "invStock": invStock,
        "invDisponible": invDisponible,
        "invTalla": invTalla,
        "invClase": invClase,
        "invTipoArma": invTipoArma,
        "invCalibre": invCalibre,
        "invColor": invColor,
        "invUso": invUso,
        "invStatus": invStatus,
        "invProveedor": List<dynamic>.from(invProveedor!.map((x) => x.toMap())),
        "invComprobantePdf": invComprobantePdf,
        "invPermisoPdf": invPermisoPdf,
        "invFecValidacion": invFecValidacion,
        "invFecCaducidad": invFecCaducidad,
        "invEstado": invEstado,
        "invEmpresa": invEmpresa,
        "invUser": invUser,
        "invFecReg": invFecReg.toString(),
        "Todos": todos,
    };
}

class InvProveedor {
    InvProveedor({
        this.id,
        this.numDocumento,
        this.nombres,
        this.numFactura,
        this.cantidad,
        this.fecFactura,
    });

    String? id;
    String? numDocumento;
    String? nombres;
    String? numFactura;
    String? cantidad;
    DateTime? fecFactura;

    factory InvProveedor.fromJson(String str) => InvProveedor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InvProveedor.fromMap(Map<String, dynamic> json) => InvProveedor(
        id: json["id"],
        numDocumento: json["numDocumento"],
        nombres: json["nombres"],
        numFactura: json["numFactura"],
        cantidad: json["cantidad"],
        fecFactura: DateTime.parse(json["fecFactura"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "numDocumento": numDocumento,
        "nombres": nombres,
        "numFactura": numFactura,
        "cantidad": cantidad,
        "fecFactura": "${fecFactura!.year.toString().padLeft(4, '0')}-${fecFactura!.month.toString().padLeft(2, '0')}-${fecFactura!.day.toString().padLeft(2, '0')}",
    };
}
