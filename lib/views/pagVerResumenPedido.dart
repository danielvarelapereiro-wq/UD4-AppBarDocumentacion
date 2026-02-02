import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';

class PagVerResumenPedido extends StatelessWidget{

  final Pedido pedido;
  const PagVerResumenPedido({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Resumen Pedido"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
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

            Text("Precio total: ${pedido.precioTotal.toStringAsFixed(2)} €",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),

            const SizedBox(height: 10),

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