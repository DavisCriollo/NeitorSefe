// To parse this JSON data, do
//
//     final allClientes = allClientesFromMap(jsonString);

import 'dart:convert';

class AllClientes {
    AllClientes({
        required this.data,
    });

    List<InfoCliente> data;

    factory AllClientes.fromJson(String str) => AllClientes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllClientes.fromMap(Map<String, dynamic> json) => AllClientes(
        data: List<InfoCliente>.from(json["data"].map((x) => InfoCliente.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class InfoCliente {
    InfoCliente({
        this.cliId,
        this.perPerfil,
        this.perEstado,
        this.cliDocTipo,
        this.cliDocNumero,
        this.cliRazonSocial,
        this.cliNombreComercial,
        this.cliNombres,
        this.cliDireccion,
        this.cliCiudad,
        this.cliInstitucion,
        this.cliUbicacion,
        this.cliTelefono,
        this.cliCelular,
        this.perEmail,
        this.cliTiempoInicioContrato,
        this.cliTiempoFinalContrato,
        this.cliAdministradorContrato,
        this.cliDatosOperativos,
        this.cliArmasAsignadas,
        this.cliEquiposAsignados,
        this.cliOtrosEquipos,
        this.cliEmpresa,
        this.perPais,
        this.perProvincia,
        this.perCanton,
        this.perFoto,
        this.perLogo,
        this.documentos,
        this.cliUser,
        this.cliObservacion,
        this.cliFecReg,
        this.todos,
    });

    int? cliId;
    List<String> ?perPerfil;
    String? perEstado;
    String? cliDocTipo;
    String? cliDocNumero;
    String? cliRazonSocial;
    String? cliNombreComercial;
    String? cliNombres;
    String? cliDireccion;
    String? cliCiudad;
    String? cliInstitucion;
    CliUbicacion? cliUbicacion;
    List<String> ?cliTelefono;
    String? cliCelular;
    List<String> ?perEmail;
    DateTime? cliTiempoInicioContrato;
    DateTime? cliTiempoFinalContrato;
    String? cliAdministradorContrato;
    List<CliDatosOperativo>? cliDatosOperativos;
    List<dynamic>? cliArmasAsignadas;
    List<dynamic>? cliEquiposAsignados;
    String? cliOtrosEquipos;
    List<String> ?cliEmpresa;
    String? perPais;
    String? perProvincia;
    String? perCanton;
    String? perFoto;
    String? perLogo;
    Documentos? documentos;
    String? cliUser;
    String? cliObservacion;
    DateTime? cliFecReg;
    String? todos;

    factory InfoCliente.fromJson(String str) => InfoCliente.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InfoCliente.fromMap(Map<String, dynamic> json) => InfoCliente(
        cliId: json["cliId"],
        perPerfil: List<String>.from(json["perPerfil"].map((x) => x)),
        perEstado: json["perEstado"],
        cliDocTipo: json["cliDocTipo"],
        cliDocNumero: json["cliDocNumero"],
        cliRazonSocial: json["cliRazonSocial"],
        cliNombreComercial: json["cliNombreComercial"],
        cliNombres: json["cliNombres"],
        cliDireccion: json["cliDireccion"],
        cliCiudad: json["cliCiudad"],
        cliInstitucion: json["cliInstitucion"],
        cliUbicacion: CliUbicacion.fromMap(json["cliUbicacion"]),
        cliTelefono: List<String>.from(json["cliTelefono"].map((x) => x)),
        cliCelular: json["cliCelular"],
        perEmail: List<String>.from(json["perEmail"].map((x) => x)),
        cliTiempoInicioContrato: DateTime.parse(json["cliTiempoInicioContrato"]),
        cliTiempoFinalContrato: DateTime.parse(json["cliTiempoFinalContrato"]),
        cliAdministradorContrato: json["cliAdministradorContrato"],
        cliDatosOperativos: List<CliDatosOperativo>.from(json["cliDatosOperativos"].map((x) => CliDatosOperativo.fromMap(x))),
        cliArmasAsignadas: List<dynamic>.from(json["cliArmasAsignadas"].map((x) => x)),
        cliEquiposAsignados: List<dynamic>.from(json["cliEquiposAsignados"].map((x) => x)),
        cliOtrosEquipos: json["cliOtrosEquipos"],
        cliEmpresa: List<String>.from(json["cliEmpresa"].map((x) => x)),
        perPais: json["perPais"],
        perProvincia: json["perProvincia"],
        perCanton: json["perCanton"],
        perFoto: json["perFoto"],
        perLogo: json["perLogo"],
        documentos: Documentos.fromMap(json["documentos"]),
        cliUser: json["cliUser"],
        cliObservacion: json["cliObservacion"],
        cliFecReg: DateTime.parse(json["cliFecReg"]),
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "cliId": cliId,
        "perPerfil": List<dynamic>.from(perPerfil!.map((x) => x)),
        "perEstado": perEstado,
        "cliDocTipo": cliDocTipo,
        "cliDocNumero": cliDocNumero,
        "cliRazonSocial": cliRazonSocial,
        "cliNombreComercial": cliNombreComercial,
        "cliNombres": cliNombres,
        "cliDireccion": cliDireccion,
        "cliCiudad": cliCiudad,
        "cliInstitucion": cliInstitucion,
        "cliUbicacion": cliUbicacion!.toMap(),
        "cliTelefono": List<dynamic>.from(cliTelefono!.map((x) => x)),
        "cliCelular": cliCelular,
        "perEmail": List<dynamic>.from(perEmail!.map((x) => x)),
        "cliTiempoInicioContrato": "${cliTiempoInicioContrato!.year.toString().padLeft(4, '0')}-${cliTiempoInicioContrato!.month.toString().padLeft(2, '0')}-${cliTiempoInicioContrato!.day.toString().padLeft(2, '0')}",
        "cliTiempoFinalContrato": "${cliTiempoFinalContrato!.year.toString().padLeft(4, '0')}-${cliTiempoFinalContrato!.month.toString().padLeft(2, '0')}-${cliTiempoFinalContrato!.day.toString().padLeft(2, '0')}",
        "cliAdministradorContrato": cliAdministradorContrato,
        "cliDatosOperativos": List<dynamic>.from(cliDatosOperativos!.map((x) => x.toMap())),
        "cliArmasAsignadas": List<dynamic>.from(cliArmasAsignadas!.map((x) => x)),
        "cliEquiposAsignados": List<dynamic>.from(cliEquiposAsignados!.map((x) => x)),
        "cliOtrosEquipos": cliOtrosEquipos,
        "cliEmpresa": List<dynamic>.from(cliEmpresa!.map((x) => x)),
        "perPais": perPais,
        "perProvincia": perProvincia,
        "perCanton": perCanton,
        "perFoto": perFoto,
        "perLogo": perLogo,
        "documentos": documentos!.toMap(),
        "cliUser": cliUser,
        "cliObservacion": cliObservacion,
        "cliFecReg": cliFecReg.toString(),
        "Todos": todos,
    };
}

class CliDatosOperativo {
    CliDatosOperativo({
        this.ubicacion,
        this.puesto,
        this.supervisor,
        this.guardias,
        this.horasservicio,
        this.tipoinstalacion,
        this.vulnerabilidades,
        this.consignas,
    });

    String? ubicacion;
    String? puesto;
    String? supervisor;
    String? guardias;
    String? horasservicio;
    String? tipoinstalacion;
    String? vulnerabilidades;
    List<dynamic>? consignas;

    factory CliDatosOperativo.fromJson(String str) => CliDatosOperativo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CliDatosOperativo.fromMap(Map<String, dynamic> json) => CliDatosOperativo(
        ubicacion: json["ubicacion"],
        puesto: json["puesto"],
        supervisor: json["supervisor"],
        guardias: json["guardias"],
        horasservicio: json["horasservicio"],
        tipoinstalacion: json["tipoinstalacion"],
        vulnerabilidades: json["vulnerabilidades"],
        consignas: List<dynamic>.from(json["consignas"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "ubicacion": ubicacion,
        "puesto": puesto,
        "supervisor": supervisor,
        "guardias": guardias,
        "horasservicio": horasservicio,
        "tipoinstalacion": tipoinstalacion,
        "vulnerabilidades": vulnerabilidades,
        "consignas": List<dynamic>.from(consignas!.map((x) => x)),
    };
}

class CliUbicacion {
    CliUbicacion({
        required this.longitud,
        required this.latitud,
    });

    double longitud;
    double latitud;

    factory CliUbicacion.fromJson(String str) => CliUbicacion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CliUbicacion.fromMap(Map<String, dynamic> json) => CliUbicacion(
        longitud: json["longitud"].toDouble(),
        latitud: json["latitud"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "longitud": longitud,
        "latitud": latitud,
    };
}

class Documentos {
    Documentos({
        this.fotosinstalacion,
        this.fotosinstalacionexpira,
        this.documentoruc,
        this.documentorucexpira,
        this.documentocontrato,
        this.documentocontratoexpira,
        this.documentoadjudicacion,
        this.documentoadjudicacionexpira,
        this.actaentregarecepciondefinitiva,
        this.actaentregarecepciondefinitivaexpira,
    });

    String? fotosinstalacion;
    String? fotosinstalacionexpira;
    String? documentoruc;
    String? documentorucexpira;
    String? documentocontrato;
    String? documentocontratoexpira;
    String? documentoadjudicacion;
    String? documentoadjudicacionexpira;
    String? actaentregarecepciondefinitiva;
    String? actaentregarecepciondefinitivaexpira;

    factory Documentos.fromJson(String str) => Documentos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Documentos.fromMap(Map<String, dynamic> json) => Documentos(
        fotosinstalacion: json["fotosinstalacion"],
        fotosinstalacionexpira: json["fotosinstalacionexpira"],
        documentoruc: json["documentoruc"],
        documentorucexpira: json["documentorucexpira"],
        documentocontrato: json["documentocontrato"],
        documentocontratoexpira: json["documentocontratoexpira"],
        documentoadjudicacion: json["documentoadjudicacion"],
        documentoadjudicacionexpira: json["documentoadjudicacionexpira"],
        actaentregarecepciondefinitiva: json["actaentregarecepciondefinitiva"],
        actaentregarecepciondefinitivaexpira: json["actaentregarecepciondefinitivaexpira"],
    );

    Map<String, dynamic> toMap() => {
        "fotosinstalacion": fotosinstalacion,
        "fotosinstalacionexpira": fotosinstalacionexpira,
        "documentoruc": documentoruc,
        "documentorucexpira": documentorucexpira,
        "documentocontrato": documentocontrato,
        "documentocontratoexpira": documentocontratoexpira,
        "documentoadjudicacion": documentoadjudicacion,
        "documentoadjudicacionexpira": documentoadjudicacionexpira,
        "actaentregarecepciondefinitiva": actaentregarecepciondefinitiva,
        "actaentregarecepciondefinitivaexpira": actaentregarecepciondefinitivaexpira,
    };
}



