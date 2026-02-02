import 'package:application_bar_ud4/models/producto.dart';

/// Modelo que representa un producto en un pedido.
/// Parámetros:
/// - [producto]: El producto asociado.
/// - [cantidad]: La cantidad de ese producto en el pedido.
class ProductoPedido {
  final Producto producto;
  int cantidad;

  /// Constructor de la clase ProductoPedido.
  ProductoPedido({required this.producto, required this.cantidad});

  /// Calcula el precio total del producto basado en su cantidad.
  double get precioProdPorUds => producto.precioUd * cantidad;

}