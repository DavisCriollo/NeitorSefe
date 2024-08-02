

// To parse this JSON data, do
//
//     final allPersonasDesignadas = allPersonasDesignadasFromMap(jsonString);

import 'dart:convert';

class AllPersonasDesignadas {
    AllPersonasDesignadas({
        required this.data,
    });

    List<InfoPersona> data;

    factory AllPersonasDesignadas.fromJson(String str) => AllPersonasDesignadas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllPersonasDesignadas.fromMap(Map<String, dynamic> json) => AllPersonasDesignadas(
        data: List<InfoPersona>.from(json["data"].map((x) => InfoPersona.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class InfoPersona {
    InfoPersona({
        this.perId,
        this.perDocNumero,
        this.perNombres,
        this.perApellidos,
        this.asignado,
        this.perFoto, docnumero,
    });

    int? perId;
    String? perDocNumero;
    String? perNombres;
    String? perApellidos;
    bool? asignado;
    String? perFoto;

    factory InfoPersona.fromJson(String str) => InfoPersona.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InfoPersona.fromMap(Map<String, dynamic> json) => InfoPersona(
        perId: json["perId"],
        perDocNumero: json["perDocNumero"],
        perNombres: json["perNombres"],
        perApellidos: json["perApellidos"],
        asignado: json["asignado"]=true,
        perFoto: json["perFoto"],
    );

    Map<String, dynamic> toMap() => {
        "perId": perId,
        "perDocNumero": perDocNumero,
        "perNombres": perNombres,
        "perApellidos": perApellidos,
        "asignado": asignado,
        "perFoto": perFoto,
    };
}
















// // To parse this JSON data, do
// //
// //     final allPersonasDesignadas = allPersonasDesignadasFromMap(jsonString);

// import 'dart:convert';

// class AllPersonasDesignadas {
//     AllPersonasDesignadas({
//         required this.data,
//     });

//     List<InfoPersona> data;

//     factory AllPersonasDesignadas.fromJson(String str) => AllPersonasDesignadas.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory AllPersonasDesignadas.fromMap(Map<String, dynamic> json) => AllPersonasDesignadas(
//         data: List<InfoPersona>.from(json["data"].map((x) => InfoPersona.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//     };
// }

// class InfoPersona {
//     InfoPersona({
//         this.perId,
//         this.perDocTipo,
//         this.perDocNumero,
//         this.perPerfil,
//         this.perNombres,
//         this.perApellidos,
//         this.perEstadoCivil,
//         this.perTelefono,
//         this.perCelular,
//         this.perInstruccion,
//         this.perCapacitacion,
//         this.perDireccion,
//         this.perFecNacimiento,
//         this.perNumContrato,
//         this.perTipoSangre,
//         this.perEmail,
//         this.perExperiencia,
//         this.perFecVinculacion,
//         this.perFormaPago,
//         this.perRemuneracion,
//         this.perLugarTrabajo,
//         this.perAreaDepartamento,
//         this.perPuestoServicio,
//         this.perTipoCuenta,
//         this.perBancoRemuneracion,
//         this.perFecRetiro,
//         this.perBonos,
//         this.perEstado,
//         this.perTurno,
//         this.perCargo,
//         this.perTipoContrato,
//         this.perLicencias,
//         this.perCtaBancaria,
//         this.perEmpresa,
//         this.perPais,
//         this.perProvincia,
//         this.perCanton,
//         this.perObservacion,
//         this.perUser,
//         this.perFoto,
//         this.perDocfotocarnet,
//         this.perDocdatospersonales,
//         this.perFecExpdatospersonales,
//         this.perCv,
//         this.perFecExpcv,
//         this.perDoccopiacedula,
//         this.perFecExpcopiacedula,
//         this.perDoctitulobachiller,
//         this.perFecExptitulobachiller,
//         this.perDoclibretamilitar,
//         this.perFecExplibretamilitar,
//         this.perDoccurso120H,
//         this.perFecExpcurso120H,
//         this.perDoctitulo120H,
//         this.perFecExptitulo120H,
//         this.perDocreentramiento,
//         this.perFecExpreentramiento,
//         this.perDoccertificadomedico,
//         this.perFecExpcertificadomedico,
//         this.perDoccertificadopsicologico,
//         this.perFecExpcertificadopsicologico,
//         this.perDoccertificadoexperiencia,
//         this.perFecExpcertificadoexperiencia,
//         this.perDoccroquisdomicilio,
//         this.perFecExpcroquisdomicilio,
//         this.perDocantecedentespenales,
//         this.perFecExpantecedentespenales,
//         this.perDocviolenciaintrafamiliar,
//         this.perFecExpviolenciaintrafamiliar,
//         this.perDoccertificadoafis,
//         this.perFecExpcertificadoafis,
//         this.perDociesshistoriallaboral,
//         this.perFecExpiesshistoriallaboral,
//         this.perDoccapacitacion,
//         this.perFecExpcapacitacion,
//         this.perDocsicosep,
//         this.perFecExpsicosep,
//         this.perDoccertificadobancario,
//         this.perFecExpcertificadobancario,
//         this.perDoclicenciaconducir,
//         this.perFecExplicenciaconducir,
//         this.perFecReg,
//         this.todos,
//     });

//     int? perId;
//     String? perDocTipo;
//     String? perDocNumero;
//     List<String>? perPerfil;
//     String? perNombres;
//     String? perApellidos;
//     String? perEstadoCivil;
//     String? perTelefono;
//     String? perCelular;
//     String? perInstruccion;
//     String? perCapacitacion;
//     String? perDireccion;
//     DateTime? perFecNacimiento;
//     String? perNumContrato;
//     String? perTipoSangre;
//     List<String>? perEmail;
//     String? perExperiencia;
//     DateTime? perFecVinculacion;
//     String? perFormaPago;
//     String? perRemuneracion;
//     String? perLugarTrabajo;
//     String? perAreaDepartamento;
//     List<PerPuestoServicio>? perPuestoServicio;
//     String? perTipoCuenta;
//     String? perBancoRemuneracion;
//     String? perFecRetiro;
//     String? perBonos;
//     String? perEstado;
//     String? perTurno;
//     String? perCargo;
//     String? perTipoContrato;
//     List<String>? perLicencias;
//     String? perCtaBancaria;
//     List<String>? perEmpresa;
//     String? perPais;
//     String? perProvincia;
//     String? perCanton;
//     String? perObservacion;
//     String? perUser;
//     String? perFoto;
//     String? perDocfotocarnet;
//     String? perDocdatospersonales;
//     String? perFecExpdatospersonales;
//     String? perCv;
//     String? perFecExpcv;
//     String? perDoccopiacedula;
//     String? perFecExpcopiacedula;
//     String? perDoctitulobachiller;
//     String? perFecExptitulobachiller;
//     String? perDoclibretamilitar;
//     String? perFecExplibretamilitar;
//     String? perDoccurso120H;
//     String? perFecExpcurso120H;
//     String? perDoctitulo120H;
//     String? perFecExptitulo120H;
//     String? perDocreentramiento;
//     String? perFecExpreentramiento;
//     String? perDoccertificadomedico;
//     String? perFecExpcertificadomedico;
//     String? perDoccertificadopsicologico;
//     String? perFecExpcertificadopsicologico;
//     String? perDoccertificadoexperiencia;
//     String? perFecExpcertificadoexperiencia;
//     String? perDoccroquisdomicilio;
//     String? perFecExpcroquisdomicilio;
//     String? perDocantecedentespenales;
//     String? perFecExpantecedentespenales;
//     String? perDocviolenciaintrafamiliar;
//     String? perFecExpviolenciaintrafamiliar;
//     String? perDoccertificadoafis;
//     String? perFecExpcertificadoafis;
//     String? perDociesshistoriallaboral;
//     String? perFecExpiesshistoriallaboral;
//     String? perDoccapacitacion;
//     String? perFecExpcapacitacion;
//     String? perDocsicosep;
//     String? perFecExpsicosep;
//     String? perDoccertificadobancario;
//     String? perFecExpcertificadobancario;
//     String? perDoclicenciaconducir;
//     String? perFecExplicenciaconducir;
//     DateTime? perFecReg;
//     String? todos;

//     factory InfoPersona.fromJson(String str) => InfoPersona.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory InfoPersona.fromMap(Map<String, dynamic> json) => InfoPersona(
//         perId: json["perId"],
//         perDocTipo: json["perDocTipo"],
//         perDocNumero: json["perDocNumero"],
//         perPerfil: List<String>.from(json["perPerfil"].map((x) => x)),
//         perNombres: json["perNombres"],
//         perApellidos: json["perApellidos"],
//         perEstadoCivil: json["perEstadoCivil"],
//         perTelefono: json["perTelefono"],
//         perCelular: json["perCelular"],
//         perInstruccion: json["perInstruccion"],
//         perCapacitacion: json["perCapacitacion"],
//         perDireccion: json["perDireccion"],
//         perFecNacimiento: DateTime.parse(json["perFecNacimiento"]),
//         perNumContrato: json["perNumContrato"],
//         perTipoSangre: json["perTipoSangre"],
//         perEmail: List<String>.from(json["perEmail"].map((x) => x)),
//         perExperiencia: json["perExperiencia"],
//         perFecVinculacion: DateTime.parse(json["perFecVinculacion"]),
//         perFormaPago: json["perFormaPago"],
//         perRemuneracion: json["perRemuneracion"],
//         perLugarTrabajo: json["perLugarTrabajo"],
//         perAreaDepartamento: json["perAreaDepartamento"],
//         perPuestoServicio: List<PerPuestoServicio>.from(json["perPuestoServicio"].map((x) => PerPuestoServicio.fromMap(x))),
//         perTipoCuenta: json["perTipoCuenta"],
//         perBancoRemuneracion: json["perBancoRemuneracion"],
//         perFecRetiro: json["perFecRetiro"],
//         perBonos: json["perBonos"],
//         perEstado: json["perEstado"],
//         perTurno: json["perTurno"],
//         perCargo: json["perCargo"],
//         perTipoContrato: json["perTipoContrato"],
//         perLicencias: List<String>.from(json["perLicencias"].map((x) => x)),
//         perCtaBancaria: json["perCtaBancaria"],
//         perEmpresa: List<String>.from(json["perEmpresa"].map((x) => x)),
//         perPais: json["perPais"],
//         perProvincia: json["perProvincia"],
//         perCanton: json["perCanton"],
//         perObservacion: json["perObservacion"],
//         perUser: json["perUser"],
//         perFoto: json["perFoto"],
//         perDocfotocarnet: json["perDocfotocarnet"],
//         perDocdatospersonales: json["perDocdatospersonales"],
//         perFecExpdatospersonales: json["perFecExpdatospersonales"],
//         perCv: json["perCv"],
//         perFecExpcv: json["perFecExpcv"],
//         perDoccopiacedula: json["perDoccopiacedula"],
//         perFecExpcopiacedula: json["perFecExpcopiacedula"],
//         perDoctitulobachiller: json["perDoctitulobachiller"],
//         perFecExptitulobachiller: json["perFecExptitulobachiller"],
//         perDoclibretamilitar: json["perDoclibretamilitar"],
//         perFecExplibretamilitar: json["perFecExplibretamilitar"],
//         perDoccurso120H: json["perDoccurso120h"],
//         perFecExpcurso120H: json["perFecExpcurso120h"],
//         perDoctitulo120H: json["perDoctitulo120h"],
//         perFecExptitulo120H: json["perFecExptitulo120h"],
//         perDocreentramiento: json["perDocreentramiento"],
//         perFecExpreentramiento: json["perFecExpreentramiento"],
//         perDoccertificadomedico: json["perDoccertificadomedico"],
//         perFecExpcertificadomedico: json["perFecExpcertificadomedico"],
//         perDoccertificadopsicologico: json["perDoccertificadopsicologico"],
//         perFecExpcertificadopsicologico: json["perFecExpcertificadopsicologico"],
//         perDoccertificadoexperiencia: json["perDoccertificadoexperiencia"],
//         perFecExpcertificadoexperiencia: json["perFecExpcertificadoexperiencia"],
//         perDoccroquisdomicilio: json["perDoccroquisdomicilio"],
//         perFecExpcroquisdomicilio: json["perFecExpcroquisdomicilio"],
//         perDocantecedentespenales: json["perDocantecedentespenales"],
//         perFecExpantecedentespenales: json["perFecExpantecedentespenales"],
//         perDocviolenciaintrafamiliar: json["perDocviolenciaintrafamiliar"],
//         perFecExpviolenciaintrafamiliar: json["perFecExpviolenciaintrafamiliar"],
//         perDoccertificadoafis: json["perDoccertificadoafis"],
//         perFecExpcertificadoafis: json["perFecExpcertificadoafis"],
//         perDociesshistoriallaboral: json["perDociesshistoriallaboral"],
//         perFecExpiesshistoriallaboral: json["perFecExpiesshistoriallaboral"],
//         perDoccapacitacion: json["perDoccapacitacion"],
//         perFecExpcapacitacion: json["perFecExpcapacitacion"],
//         perDocsicosep: json["perDocsicosep"],
//         perFecExpsicosep: json["perFecExpsicosep"],
//         perDoccertificadobancario: json["perDoccertificadobancario"],
//         perFecExpcertificadobancario: json["perFecExpcertificadobancario"],
//         perDoclicenciaconducir: json["perDoclicenciaconducir"],
//         perFecExplicenciaconducir: json["perFecExplicenciaconducir"],
//         perFecReg: DateTime.parse(json["perFecReg"]),
//         todos: json["Todos"],
//     );

//     Map<String, dynamic> toMap() => {
//         "perId": perId,
//         "perDocTipo": perDocTipo,
//         "perDocNumero": perDocNumero,
//         "perPerfil": List<dynamic>.from(perPerfil!.map((x) => x)),
//         "perNombres": perNombres,
//         "perApellidos": perApellidos,
//         "perEstadoCivil": perEstadoCivil,
//         "perTelefono": perTelefono,
//         "perCelular": perCelular,
//         "perInstruccion": perInstruccion,
//         "perCapacitacion": perCapacitacion,
//         "perDireccion": perDireccion,
//         "perFecNacimiento": "${perFecNacimiento!.year.toString().padLeft(4, '0')}-${perFecNacimiento!.month.toString().padLeft(2, '0')}-${perFecNacimiento!.day.toString().padLeft(2, '0')}",
//         "perNumContrato": perNumContrato,
//         "perTipoSangre": perTipoSangre,
//         "perEmail": List<dynamic>.from(perEmail!.map((x) => x)),
//         "perExperiencia": perExperiencia,
//         "perFecVinculacion": "${perFecVinculacion!.year.toString().padLeft(4, '0')}-${perFecVinculacion!.month.toString().padLeft(2, '0')}-${perFecVinculacion!.day.toString().padLeft(2, '0')}",
//         "perFormaPago": perFormaPago,
//         "perRemuneracion": perRemuneracion,
//         "perLugarTrabajo": perLugarTrabajo,
//         "perAreaDepartamento": perAreaDepartamento,
//         "perPuestoServicio": List<dynamic>.from(perPuestoServicio!.map((x) => x.toMap())),
//         "perTipoCuenta": perTipoCuenta,
//         "perBancoRemuneracion": perBancoRemuneracion,
//         "perFecRetiro": perFecRetiro,
//         "perBonos": perBonos,
//         "perEstado": perEstado,
//         "perTurno": perTurno,
//         "perCargo": perCargo,
//         "perTipoContrato": perTipoContrato,
//         "perLicencias": List<dynamic>.from(perLicencias!.map((x) => x)),
//         "perCtaBancaria": perCtaBancaria,
//         "perEmpresa": List<dynamic>.from(perEmpresa!.map((x) => x)),
//         "perPais": perPais,
//         "perProvincia": perProvincia,
//         "perCanton": perCanton,
//         "perObservacion": perObservacion,
//         "perUser": perUser,
//         "perFoto": perFoto,
//         "perDocfotocarnet": perDocfotocarnet,
//         "perDocdatospersonales": perDocdatospersonales,
//         "perFecExpdatospersonales": perFecExpdatospersonales,
//         "perCv": perCv,
//         "perFecExpcv": perFecExpcv,
//         "perDoccopiacedula": perDoccopiacedula,
//         "perFecExpcopiacedula": perFecExpcopiacedula,
//         "perDoctitulobachiller": perDoctitulobachiller,
//         "perFecExptitulobachiller": perFecExptitulobachiller,
//         "perDoclibretamilitar": perDoclibretamilitar,
//         "perFecExplibretamilitar": perFecExplibretamilitar,
//         "perDoccurso120h": perDoccurso120H,
//         "perFecExpcurso120h": perFecExpcurso120H,
//         "perDoctitulo120h": perDoctitulo120H,
//         "perFecExptitulo120h": perFecExptitulo120H,
//         "perDocreentramiento": perDocreentramiento,
//         "perFecExpreentramiento": perFecExpreentramiento,
//         "perDoccertificadomedico": perDoccertificadomedico,
//         "perFecExpcertificadomedico": perFecExpcertificadomedico,
//         "perDoccertificadopsicologico": perDoccertificadopsicologico,
//         "perFecExpcertificadopsicologico": perFecExpcertificadopsicologico,
//         "perDoccertificadoexperiencia": perDoccertificadoexperiencia,
//         "perFecExpcertificadoexperiencia": perFecExpcertificadoexperiencia,
//         "perDoccroquisdomicilio": perDoccroquisdomicilio,
//         "perFecExpcroquisdomicilio": perFecExpcroquisdomicilio,
//         "perDocantecedentespenales": perDocantecedentespenales,
//         "perFecExpantecedentespenales": perFecExpantecedentespenales,
//         "perDocviolenciaintrafamiliar": perDocviolenciaintrafamiliar,
//         "perFecExpviolenciaintrafamiliar": perFecExpviolenciaintrafamiliar,
//         "perDoccertificadoafis": perDoccertificadoafis,
//         "perFecExpcertificadoafis": perFecExpcertificadoafis,
//         "perDociesshistoriallaboral": perDociesshistoriallaboral,
//         "perFecExpiesshistoriallaboral": perFecExpiesshistoriallaboral,
//         "perDoccapacitacion": perDoccapacitacion,
//         "perFecExpcapacitacion": perFecExpcapacitacion,
//         "perDocsicosep": perDocsicosep,
//         "perFecExpsicosep": perFecExpsicosep,
//         "perDoccertificadobancario": perDoccertificadobancario,
//         "perFecExpcertificadobancario": perFecExpcertificadobancario,
//         "perDoclicenciaconducir": perDoclicenciaconducir,
//         "perFecExplicenciaconducir": perFecExplicenciaconducir,
//         "perFecReg": perFecReg.toString(),
//         "Todos": todos,
//     };
// }

// class PerPuestoServicio {
//     PerPuestoServicio({
//         this.ruccliente,
//         this.razonsocial,
//         this.ubicacion,
//         this.puesto,
//     });

//     String? ruccliente;
//     String? razonsocial;
//     String? ubicacion;
//     String? puesto;

//     factory PerPuestoServicio.fromJson(String str) => PerPuestoServicio.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory PerPuestoServicio.fromMap(Map<String, dynamic> json) => PerPuestoServicio(
//         ruccliente: json["ruccliente"],
//         razonsocial: json["razonsocial"],
//         ubicacion: json["ubicacion"],
//         puesto: json["puesto"],
//     );

//     Map<String, dynamic> toMap() => {
//         "ruccliente": ruccliente,
//         "razonsocial": razonsocial,
//         "ubicacion": ubicacion,
//         "puesto": puesto,
//     };
// }
