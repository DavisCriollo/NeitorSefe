class CreaNuevaFotoRealizaConsignaGuardia {
  int id;
  String path;

  CreaNuevaFotoRealizaConsignaGuardia(
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