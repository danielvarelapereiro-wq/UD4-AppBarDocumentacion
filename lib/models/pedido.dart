import 'package:application_bar_ud4/models/productoPedido.dart';

class Pedido {
  final int mesa;
  final List<ProductoPedido> productos;

  Pedido({required this.mesa, required this.productos});

  //con fold, recorremos la lista y definimos un valor inicial 0 al que le vamos sumar
  // cantPrevia + la cantidad iterando la lista, para tener el total de productos y lo mismo para el precio total
  int get totalProductos => productos.fold(0, (cantPrevia, it) => cantPrevia + it.cantidad);

  double get precioTotal => productos.fold(0.0, (precPrevio, it) => precPrevio + it.precioProdPorUds);

}