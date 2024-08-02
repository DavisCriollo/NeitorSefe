class CreaNuevaFotoComunicadoGuardia {
  int id;
  String path;

  CreaNuevaFotoComunicadoGuardia(
    this.id,
    this.path,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
    };
  }
}