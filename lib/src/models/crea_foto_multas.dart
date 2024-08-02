class CreaNuevaFotoMultas {
  int id;
  String path;

  CreaNuevaFotoMultas(
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