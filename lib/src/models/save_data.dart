// To parse this JSON data, do
//
//     final dataUsuario = dataUsuarioFromMap(jsonString);

import 'dart:convert';

class DataUsuario {
    DataUsuario({
        this.usuario,
        this.password,
        this.empresa,
        this.recuerdaCredenciales,
    });

    String? usuario;
    String? password;
    String? empresa;
    bool? recuerdaCredenciales;

    factory DataUsuario.fromJson(String str) => DataUsuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DataUsuario.fromMap(Map<String, dynamic> json) => DataUsuario(
        usuario: json["usuario"],
        password: json["password"],
        empresa: json["empresa"],
        recuerdaCredenciales: json["recuerdaCredenciales"],
    );

    Map<String, dynamic> toMap() => {
        "usuario": usuario,
        "password": password,
        "empresa": empresa,
        "recuerdaCredenciales": recuerdaCredenciales,
    };
}
