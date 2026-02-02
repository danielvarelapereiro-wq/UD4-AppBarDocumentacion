import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';
import 'package:application_bar_ud4/models/productoPedido.dart';
import 'package:application_bar_ud4/viewmodels/pedidoViewModel.dart';
import 'pagAnadirProductos.dart';

class PagPedido extends StatefulWidget {
  final Pedidoviewmodel viewModel;
  const PagPedido({super.key, required this.viewModel});

  @override
  State<PagPedido> createState() => _PagPedidoState();

}

class _PagPedidoState extends State<PagPedido> {

  final TextEditingController mesaControler = TextEditingController();
  List<ProductoPedido> produSelec = [];

  int get prodTotal => produSelec.fold(0,(sum, pro) => sum + pro.cantidad);

  double get precTotal => produSelec.fold(0.0, (sum, pro) => sum + pro.precioProdPorUds);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Pedido"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: mesaControler,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Mesa:"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async{
                final seleccion = await Navigator.push<List<ProductoPedido>>(
                  context, MaterialPageRoute(
                    builder: (_) => PagAnadirProducto(
                      productosSelec: produSelec,
                      viewModel: widget.viewModel
                    ),
                  ),
                );

                if(seleccion!= null && mounted) {
                  setState(() {
                    produSelec = seleccion;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black
                    ),
              child: const Text("Añadir Productos"),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[180],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Resumen pedido:"),
                  Text(
                    produSelec.isEmpty
                      ? "No hay productos añadidos"
                      : produSelec.map(
                        (pro) => pro.producto.nombre).join(", ")
                    ),

                    Text("Unidades $prodTotal"),
                    Text("Precio total: ${precTotal.toStringAsFixed(2)} €")
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                if(produSelec.isEmpty || mesaControler.text.isEmpty) return;

                Navigator.pushNamed(
                  context,
                  '/resumen', arguments: Pedido(
                    mesa: int.tryParse(mesaControler.text) ?? 0,
                    productos: produSelec
                    ),
                );
              },
              style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 221, 219, 71),
                      foregroundColor: Colors.black
                    ),
              child: const Text("Ver Resumen"),
            ),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 219, 82, 58),
                      foregroundColor: Colors.black
                    ),
                  child: const Text("Cancelar")
                ),

                ElevatedButton(
                  onPressed: () {
                  if(produSelec.isEmpty || mesaControler.text.isEmpty) return;

                  Navigator.pop(context, Pedido(
                    mesa: int.tryParse(mesaControler.text) ?? 0,
                    productos: produSelec
                    ),
                  ); 
                },
                style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black
                    ),
                child: const Text("Añadir Pedido")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



}