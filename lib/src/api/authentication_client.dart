import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nseguridad/src/models/auth_response.dart';
import 'package:nseguridad/src/models/session_response.dart';



class Auth {
  Auth.internal();
  static final Auth _instance = Auth.internal();
  static Auth get instance => _instance;

  final _storage = const FlutterSecureStorage();
  final keySESION = 'SESSION';
  final keyTURNO = 'TURNO';
  final keyCREDENCIALES = 'CEDENCIALES';
  final keyTOKENFIREBASE = 'TOKENFIREBASE';
  final keyRONDAS = 'RONDASACTIVIDAD';
  final keyIDREGISTRO = 'IDREGISTRO';

// GUARDO LA INFORMACION EN EL DISPOSITIVO
  Future<void> saveSession(AuthResponse data) async {
    final Session session = Session(
      //============================//
      token: data.token,
      id: data.id,
      nombre: data.nombre,
      usuario: data.usuario,
      rucempresa: data.rucempresa,
      codigo: data.codigo,
      nomEmpresa: data.nomEmpresa,
      nomComercial: data.nomComercial,
      fechaCaducaFirma: data.fechaCaducaFirma,
      rol: data.rol,
      tipografia: data.tipografia,
      logo: data.logo,
      areadepartamento: data.areadepartamento,
      foto: data.foto,
      empCategoria: data.empCategoria,
      colorPrimario: data.colorPrimario,
      colorSecundario: data.colorSecundario,
      regId: data.regId,
      //============================//
    );

    final String value = jsonEncode(session.toJson());
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keySESION, value: value);
    //  print('SESION GUARDADA :$value');
  }

// OBTEMENOS LA INFORMACION DEL DISPOSITIVO
  Future<Session?> getSession() async {
    final String? value = await _storage.read(key: keySESION);
    if (value != null) {
      // final Map<String, dynamic> json = jsonDecode(value);
      final session = Session.fromJson(jsonDecode(value));
      return session;
    }
    return null;
  }

  // CIERRO SESSION
  Future<void> deleteSesion(BuildContext context) async {
    // await _storage.deleteAll();
    await _storage.delete(key: keySESION);
    //  print('SESION ELIMINADA:$keySESION');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => false);
  }
  // CIERRO SESSION
  Future<void> deleteCache(BuildContext context) async {
    // await _storage.deleteAll();
    await _storage.delete(key: keySESION);
 
  }

  Future<void> saveTurnoSession(bool data) async {
    if (data == true) {
      String? iniciaTurno = 'INICIATURNO';
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
      await _storage.write(key: keyTURNO, value: iniciaTurno);
    }
  }

  // OBTEMENOS EL TURNO  DEL DISPOSITIVO
  Future getTurnoSession() async {
    final String? value = await _storage.read(key: keyTURNO);
    if (value != null) {
      return value;
    }
    return null;
  }

  // CIERRO TURNO
  Future<void> deleteTurnoSesion() async {
    await _storage.delete(key: keyTURNO);
  }

  // ============================================= TOKEN FIREBASE =======================//

  Future<void> saveTokenFireBase(String data) async {
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyTOKENFIREBASE, value: data);
      print(' FCM GUARDADO:$data');
  }

  // OBTEMENOS EL TOKENFIREBASE   DEL DISPOSITIVO
  Future getTokenFireBase() async {
    final String? value = await _storage.read(key: keyTOKENFIREBASE);
    if (value != null) {
      return value;
    }
    return null;
  }

  // ELIMINA TOKEN FIREBASE
  Future<void> deleteTokenFireBase() async {
   
    await _storage.delete(key: keyTOKENFIREBASE);
     print('turno FCM eliminado:$keyTOKENFIREBASE');
  }

  // ============================================= GUARDA ID REGISTRO =======================//

  Future<void> saveIdRegistro(String? data) async {
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyIDREGISTRO, value: data);

    // print('turno guardado:$data');
   
  }

  // OBTEMENOS EL ID REGISTRO  DEL DISPOSITIVO
  Future getIdRegistro() async {
    final String? value = await _storage.read(key: keyIDREGISTRO);
    if (value != null) {
      return value;
    }
    return null;
  }

  // ELIMINA ID REGISTRO
  Future<void> deleteIdRegistro() async {
    await _storage.delete(key: keyIDREGISTRO);
  }

  // ============================================= ARRAY DE RONDAS =======================//

  Future<void> saveRondasActividad(String data) async {
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyRONDAS, value: data);
  }

  // OBTEMENOS EL RondasActividad   DEL DISPOSITIVO
  Future getRondasActividad() async {
    final String? value = await _storage.read(key: keyRONDAS);
    if (value != null) {
      return value;
    }
    return null;
  }

  // ELIMINA RondasActividad
  Future<void> deleteRondasActividad() async {
    await _storage.delete(key: keyRONDAS);
  }

  // ELIMINA DATOS GUARDADOS
  Future<void> deleteAll(BuildContext context) async {
    await _storage.deleteAll();
    // await _storage.delete(key: keySESION);
  }

  Future<void> saveTurnoSessionUser(Map<String, dynamic> infoUser) async {
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    final usuario = jsonEncode(infoUser);
    await _storage.write(key: keyTURNO, value: usuario);
  }

// OBTEMENOS EL TURNO  DEL DISPOSITIVO
  Future getTurnoSessionUsuario() async {
    final String? value = await _storage.read(key: keyTURNO);
    if (value != null) {
      return value;
    }
    return null;
  }

  // CIERRO TURNO
  Future<void> deleteTurnoSesionUser() async {
    await _storage.delete(key: keyTURNO);
  }

  //=========================================================================//
  // GUARDO RECORDAR CONTRASENA EN EL DISPOSITIVO
  Future<void> saveDataRecordarme(List<dynamic> _recordarme) async {
// CONVERTIMOS  LA INFORMACION  A STRING PARA GUARDAR AL DISPOSITIVO
    final String value = jsonEncode(_recordarme);
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyCREDENCIALES, value: value);
  }

// OBTEMENOS LA INFORMACION DEL credenciales
  Future getDataRecordarme() async {
    final String? datosCredencial = await _storage.read(key: keyCREDENCIALES);
    if (datosCredencial != null) {
      final getDatosCredencial = jsonDecode(datosCredencial);
      return getDatosCredencial;
    }
    return null;
  }

// CIERRO SESSION
  Future<void> deleteDataRecordarme() async {
    await _storage.delete(key: keyCREDENCIALES);
  }

  //=========================================================================//

}
