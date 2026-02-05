import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';
/// Página para mostrar el resumen de un pedido.
/// Muestra los detalles del pedido, incluyendo la mesa, los productos seleccionados, sus cantidades y precios, y el precio total.
/// Parámetros:
/// - [pedido]: El pedido del que se mostrará el resumen.
class PagVerResumenPedido extends StatelessWidget{
  /// Pedido del que se mostrará el resumen.
  final Pedido pedido;

  /// Constructor de la clase PagVerResumenPedido.
  /// Recibe el pedido como parámetro requerido.
  const PagVerResumenPedido({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    /// Construye la interfaz de usuario de la página para mostrar el resumen del pedido.
    return Scaffold(
      appBar: AppBar(title: const Text("Resumen Pedido"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        /// Contenedor principal que muestra los detalles del pedido.
        child: Column(
          children: [
            Text("Mesa ${pedido.mesa}",
            style: const TextStyle(fontSize: 20)),

            const SizedBox(height: 10),

            Row(
              children: const [
                Expanded(child: Text("Prod.")),
                Expanded(child: Text("Prec/Ud.")),
                Expanded(child: Text("Uds.")),
                Expanded(child: Text("Prec.")),
              ],
            ),

            const Divider(),
            /// Muestra la lista de productos del pedido, con su nombre, precio por unidad, cantidad y precio total por producto.
            /// Se utiliza un map para generar una fila por cada producto en el pedido.
            ...pedido.productos.map((pro) => Row(
              children: [
                Expanded(child: Text(pro.producto.nombre)),
                Expanded(child: Text(pro.producto.precioUd.toStringAsFixed(2))),
                Expanded(child: Text(pro.cantidad.toString())),
                Expanded(child: Text(pro.precioProdPorUds.toStringAsFixed(2))),
              ],
            )),

            const Spacer(),

            const Divider(),
            /// Muestra el precio total del pedido, formateado a dos decimales.
            Text("Precio total: ${pedido.precioTotal.toStringAsFixed(2)} €",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),

            const SizedBox(height: 10),
            /// Botón para cerrar la página del resumen del pedido.
            /// Al pulsar el botón, se cierra la página mediante Navigator.pop.
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black
                    ),
                child: const Text("OK")),
            ),
          ],
        ),
      ),
    );

  }
}