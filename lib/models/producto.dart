/// Modelo que representa un producto.
/// Parámetros:
/// - [id]: Identificador único del producto.
/// - [nombre]: Nombre del producto.
/// - [precioUd]: Precio por unidad del producto.
class Producto {
  final int id;
  final String nombre;
  final double precioUd;

  /// Constructor de la clase Producto.
  Producto({required this.id,required this.nombre,required this.precioUd});
  
}