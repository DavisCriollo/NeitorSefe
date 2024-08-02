
class CreaNuevoItemPedido {
  int id;
  String? cantidadDevolucion='0';
 String nombre, cantidad,tipo,serie,pedido;

  CreaNuevoItemPedido(this.id,this.cantidadDevolucion, this.nombre, this.cantidad,this.tipo,this.serie,this.pedido);

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'nombre': nombre,
      'cantidad': cantidad,
      'tipo': tipo,
      'serie': serie,
      "estado":pedido,
      "cantidadDevolucion": cantidadDevolucion
        };
  }
}
