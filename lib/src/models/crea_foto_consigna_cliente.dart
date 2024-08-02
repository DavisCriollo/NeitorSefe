class CreaNuevaFotoConsignaCliente {
  int id;
  String path;

  CreaNuevaFotoConsignaCliente(
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