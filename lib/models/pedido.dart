import 'package:application_bar_ud4/models/productoPedido.dart';

/// Modelo que representa un pedido.
/// Parámetros:
/// - [mesa]: Número de mesa del pedido.
/// - [productos]: Lista de productos en el pedido.
class Pedido {
  final int mesa;
  final List<ProductoPedido> productos;

  /// Constructor de la clase Pedido.
  Pedido({required this.mesa, required this.productos});

  //con fold, recorremos la lista y definimos un valor inicial 0 al que le vamos sumar
  // cantPrevia + la cantidad iterando la lista, para tener el total de productos y lo mismo para el precio total
  
  /// Calcula el total de productos en el pedido.
  int get totalProductos => productos.fold(0, (cantPrevia, it) => cantPrevia + it.cantidad);

  /// Calcula el precio total del pedido.
  double get precioTotal => productos.fold(0.0, (precPrevio, it) => precPrevio + it.precioProdPorUds);

}