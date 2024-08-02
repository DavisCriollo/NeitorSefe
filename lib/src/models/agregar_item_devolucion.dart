class AgregarItemDevolucionPedido {
  int id;
  String nombre, cantidad,tipo,serie,idProduct;

  AgregarItemDevolucionPedido(this.id, this.nombre, this.cantidad,this.tipo,this.serie,this.idProduct);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidad': cantidad,
      'tipo': tipo,
      'serie': serie,
      'idProduct': idProduct,
        };
  }
}
