class CreaNuevaFotoNovedad {
  int id;
  String path;

  CreaNuevaFotoNovedad(
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
