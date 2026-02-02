import 'package:application_bar_ud4/models/producto.dart';

class ProductoPedido {
  final Producto producto;
  int cantidad;

  ProductoPedido({required this.producto, required this.cantidad});

  double get precioProdPorUds => producto.precioUd * cantidad;

}