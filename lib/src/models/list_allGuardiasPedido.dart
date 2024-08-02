

import 'dart:convert';

class AllGuardiasPedido {
    AllGuardiasPedido({
        required this.data,
    });

    List<Guardia> data;

    factory AllGuardiasPedido.fromJson(String str) => AllGuardiasPedido.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllGuardiasPedido.fromMap(Map<String, dynamic> json) => AllGuardiasPedido(
        data: List<Guardia>.from(json["data"].map((x) => Guardia.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Guardia {
    Guardia({
        this.perId,
        this.perDocTipo,
        this.perDocNumero,
        this.perPerfil,
        this.perNombres,
        this.perApellidos,
        this.perEstadoCivil,
        this.perTelefono,
        this.perCelular,
        this.perInstruccion,
        this.perCapacitacion,
        this.perDireccion,
        this.perFecNacimiento,
        this.perCiudad,
        this.perNumContrato,
        this.perTipoSangre,
        this.perEmail,
        this.perExperiencia,
        this.perFecVinculacion,
        this.perFormaPago,
        this.perRemuneracion,
        this.perLugarTrabajo,
        this.perAreaDepartamento,
        this.perPuestoServicio,
        this.perTipoCuenta,
        this.perBancoRemuneracion,
        this.perFecRetiro,
        this.perBonos,
        this.perEstado,
        this.perTurno,
        this.perCargo,
        this.perTipoContrato,
        this.perLicencias,
        this.perCtaBancaria,
        this.perEmpresa,
        this.perPais,
        this.perProvincia,
        this.perCanton,
        this.perObservacion,
        this.perUser,
        this.perFoto,
        this.perFotoCarnet,
        this.documentos,
        this.perFecReg,
        this.otros,
        this.todos,
    });

    int? perId;
    String? perDocTipo;
    String? perDocNumero;
    List<String>? perPerfil;
    String? perNombres;
    String? perApellidos;
    String? perEstadoCivil;
    List<String>? perTelefono;
    String? perCelular;
    String? perInstruccion;
    String? perCapacitacion;
    String? perDireccion;
    DateTime? perFecNacimiento;
    String? perCiudad;
    String? perNumContrato;
    String? perTipoSangre;
    List<String>? perEmail;
    String? perExperiencia;
    DateTime? perFecVinculacion;
    String? perFormaPago;
    String? perRemuneracion;
    String? perLugarTrabajo;
    String? perAreaDepartamento;
    List<PerPuestoServicio>? perPuestoServicio;
    String? perTipoCuenta;
    String? perBancoRemuneracion;
    String? perFecRetiro;
    String? perBonos;
    String? perEstado;
    List<String>? perTurno;
    String? perCargo;
    String? perTipoContrato;
    List<String>? perLicencias;
    String? perCtaBancaria;
    List<String>? perEmpresa;
    String? perPais;
    String? perProvincia;
    String? perCanton;
    String? perObservacion;
    String? perUser;
    String? perFoto;
    String? perFotoCarnet;
    Documentos? documentos;
    DateTime? perFecReg;
    String? otros;
    String? todos;

    factory Guardia.fromJson(String str) => Guardia.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Guardia.fromMap(Map<String, dynamic> json) => Guardia(
        perId: json["perId"],
        perDocTipo: json["perDocTipo"],
        perDocNumero: json["perDocNumero"],
        perPerfil: List<String>.from(json["perPerfil"].map((x) => x)),
        perNombres: json["perNombres"],
        perApellidos: json["perApellidos"],
        perEstadoCivil: json["perEstadoCivil"],
        perTelefono: List<String>.from(json["perTelefono"].map((x) => x)),
        perCelular: json["perCelular"],
        perInstruccion: json["perInstruccion"],
        perCapacitacion: json["perCapacitacion"],
        perDireccion: json["perDireccion"],
        perFecNacimiento: DateTime.parse(json["perFecNacimiento"]),
        perCiudad: json["perCiudad"],
        perNumContrato: json["perNumContrato"],
        perTipoSangre: json["perTipoSangre"],
        perEmail: List<String>.from(json["perEmail"].map((x) => x)),
        perExperiencia: json["perExperiencia"],
        perFecVinculacion: DateTime.parse(json["perFecVinculacion"]),
        perFormaPago: json["perFormaPago"],
        perRemuneracion: json["perRemuneracion"],
        perLugarTrabajo: json["perLugarTrabajo"],
        perAreaDepartamento: json["perAreaDepartamento"],
        perPuestoServicio: List<PerPuestoServicio>.from(json["perPuestoServicio"].map((x) => PerPuestoServicio.fromMap(x))),
        perTipoCuenta: json["perTipoCuenta"],
        perBancoRemuneracion: json["perBancoRemuneracion"],
        perFecRetiro: json["perFecRetiro"],
        perBonos: json["perBonos"],
        perEstado: json["perEstado"],
        perTurno: List<String>.from(json["perTurno"].map((x) => x)),
        perCargo: json["perCargo"],
        perTipoContrato: json["perTipoContrato"],
        perLicencias: List<String>.from(json["perLicencias"].map((x) => x)),
        perCtaBancaria: json["perCtaBancaria"],
        perEmpresa: List<String>.from(json["perEmpresa"].map((x) => x)),
        perPais: json["perPais"],
        perProvincia: json["perProvincia"],
        perCanton: json["perCanton"],
        perObservacion: json["perObservacion"],
        perUser: json["perUser"],
        perFoto: json["perFoto"],
        perFotoCarnet: json["perFotoCarnet"],
        documentos: Documentos.fromMap(json["documentos"]),
        perFecReg: DateTime.parse(json["perFecReg"]),
        otros: json["Otros"],
        todos: json["Todos"],
    );

    Map<String, dynamic> toMap() => {
        "perId": perId,
        "perDocTipo": perDocTipo,
        "perDocNumero": perDocNumero,
        "perPerfil": List<dynamic>.from(perPerfil!.map((x) => x)),
        "perNombres": perNombres,
        "perApellidos": perApellidos,
        "perEstadoCivil": perEstadoCivil,
        "perTelefono": List<dynamic>.from(perTelefono!.map((x) => x)),
        "perCelular": perCelular,
        "perInstruccion": perInstruccion,
        "perCapacitacion": perCapacitacion,
        "perDireccion": perDireccion,
        "perFecNacimiento": "${perFecNacimiento!.year.toString().padLeft(4, '0')}-${perFecNacimiento!.month.toString().padLeft(2, '0')}-${perFecNacimiento!.day.toString().padLeft(2, '0')}",
        "perCiudad": perCiudad,
        "perNumContrato": perNumContrato,
        "perTipoSangre": perTipoSangre,
        "perEmail": List<dynamic>.from(perEmail!.map((x) => x)),
        "perExperiencia": perExperiencia,
        "perFecVinculacion": "${perFecVinculacion!.year.toString().padLeft(4, '0')}-${perFecVinculacion!.month.toString().padLeft(2, '0')}-${perFecVinculacion!.day.toString().padLeft(2, '0')}",
        "perFormaPago": perFormaPago,
        "perRemuneracion": perRemuneracion,
        "perLugarTrabajo": perLugarTrabajo,
        "perAreaDepartamento": perAreaDepartamento,
        "perPuestoServicio": List<dynamic>.from(perPuestoServicio!.map((x) => x.toMap())),
        "perTipoCuenta": perTipoCuenta,
        "perBancoRemuneracion": perBancoRemuneracion,
        "perFecRetiro": perFecRetiro,
        "perBonos": perBonos,
        "perEstado": perEstado,
        "perTurno": List<dynamic>.from(perTurno!.map((x) => x)),
        "perCargo": perCargo,
        "perTipoContrato": perTipoContrato,
        "perLicencias": List<dynamic>.from(perLicencias!.map((x) => x)),
        "perCtaBancaria": perCtaBancaria,
        "perEmpresa": List<dynamic>.from(perEmpresa!.map((x) => x)),
        "perPais": perPais,
        "perProvincia": perProvincia,
        "perCanton": perCanton,
        "perObservacion": perObservacion,
        "perUser": perUser,
        "perFoto": perFoto,
        "perFotoCarnet": perFotoCarnet,
        "documentos": documentos!.toMap(),
        "perFecReg": perFecReg.toString(),
        "Otros": otros,
        "Todos": todos,
    };
}

class Documentos {
    Documentos({
        required this.hojavida,
        required this.hojavidaexpira,
    });

    String hojavida;
    String hojavidaexpira;

    factory Documentos.fromJson(String str) => Documentos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Documentos.fromMap(Map<String, dynamic> json) => Documentos(
        hojavida: json["hojavida"],
        hojavidaexpira: json["hojavidaexpira"],
    );

    Map<String, dynamic> toMap() => {
        "hojavida": hojavida,
        "hojavidaexpira": hojavidaexpira,
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
