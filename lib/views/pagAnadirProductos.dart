import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/productoPedido.dart';
import 'package:application_bar_ud4/viewmodels/pedidoViewModel.dart';

class PagAnadirProducto extends StatefulWidget {

  final Pedidoviewmodel viewModel;
  final List<ProductoPedido> productosSelec;

  const PagAnadirProducto({super.key, required this.productosSelec, required this.viewModel});

  @override
  State<PagAnadirProducto> createState() => _PagAnadirProductoState();

}

class _PagAnadirProductoState extends State<PagAnadirProducto> {

  late List<ProductoPedido> listaProductos;

  @override
  void initState() {
    super.initState();

    listaProductos = widget.productosSelec.map((pro) => ProductoPedido(producto: pro.producto, cantidad: pro.cantidad)).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Productos"), centerTitle: true),
      body: ListView.builder(
        itemCount: widget.viewModel.listaProductos.length,
        itemBuilder: (context, i) {
          final prod = widget.viewModel.listaProductos[i];
          final selec = listaProductos.indexWhere((pro) => pro.producto.id == prod.id);

          int cantidad = selec >= 0 ? listaProductos[selec].cantidad : 0;

          return ListTile(
            title: Text(prod.nombre),
            subtitle: Text("${prod.precioUd.toStringAsFixed(2)} €"),
            trailing: SizedBox(
              width: 130,
              child: Row(
                children: [
                  //boton restar prod
                  IconButton(onPressed: selec >=0 ? () {
                    setState(() {
                      if(listaProductos[selec].cantidad > 1) {
                        listaProductos[selec].cantidad--;
                      }
                      else {
                        listaProductos.removeAt(selec);
                      }
                    });
                  } : null,
                    icon: const Icon(Icons.remove)),

                  // cantidad de producto añadido
                  Expanded(child: Center(child: Text(cantidad.toString()))),

                  //boton sumar prod
                  IconButton(onPressed: () {
                    setState(() {
                      if(selec >=0) {
                        listaProductos[selec].cantidad++;
                      }
                      else {
                        listaProductos.add(ProductoPedido(producto: prod, cantidad: 1));
                      }
                    });
                  }, icon: const Icon(Icons.add)),

                  //boton papelera borrar
                  IconButton(onPressed: selec >=0 ? () {
                    setState(() => listaProductos.removeAt(selec));
                  } : null,
                    icon: const Icon(Icons.delete)),
                ],
              ),
            ),
          );
        }
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
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
              onPressed: () => Navigator.pop(context, listaProductos.where((pro) => pro.cantidad > 0).toList()),
              style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black
                    ),
              child: const Text("Añadir Productos")
            )
          ],
        )
      ),

    );
  }

}