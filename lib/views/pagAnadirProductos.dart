import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/productoPedido.dart';
import 'package:application_bar_ud4/viewmodels/pedidoViewModel.dart';

/// Página para añadir productos a un pedido.
/// Permite seleccionar productos y ajustar sus cantidades.
/// Parámetros:
/// - [viewModel]: El ViewModel que gestiona la lógica de los pedidos.
/// - [productosSelec]: Lista inicial de productos seleccionados.
class PagAnadirProducto extends StatefulWidget {

  /// ViewModel que gestiona la lógica de los pedidos.
  final Pedidoviewmodel viewModel;

  /// Lista inicial de productos seleccionados.
  final List<ProductoPedido> productosSelec;

  /// Constructor de la clase PagAnadirProducto.
  const PagAnadirProducto({super.key, required this.productosSelec, required this.viewModel});

  
  @override
  State<PagAnadirProducto> createState() => _PagAnadirProductoState();

}

/// Estado de la página para añadir productos a un pedido.
/// Gestiona la lista de productos seleccionados y su cantidad.
class _PagAnadirProductoState extends State<PagAnadirProducto> {

  /// Lista de productos seleccionados.
  late List<ProductoPedido> listaProductos;

  /// Inicializa el estado de la página.
  /// Carga los productos seleccionados inicialmente.
  @override
  void initState() {
    super.initState();

    listaProductos = widget.productosSelec.map((pro) => ProductoPedido(producto: pro.producto, cantidad: pro.cantidad)).toList();
  }

  /// Construye la interfaz de usuario de la página.
  /// Muestra una lista de productos con opciones para ajustar cantidades.
  @override
  Widget build(BuildContext context) {

    /// Estructura principal de la página.
    return Scaffold(
      appBar: AppBar(title: const Text("Productos"), centerTitle: true),
      body: ListView.builder(
        itemCount: widget.viewModel.listaProductos.length,
        itemBuilder: (context, i) {
          /// Producto actual en la lista.
          final prod = widget.viewModel.listaProductos[i];

          /// Índice del producto en la lista de productos seleccionados.
          final selec = listaProductos.indexWhere((pro) => pro.producto.id == prod.id);

          /// Cantidad del producto seleccionado.
          int cantidad = selec >= 0 ? listaProductos[selec].cantidad : 0;

          /// Fila de la lista que muestra el producto y opciones para ajustar la cantidad.
          return ListTile(
            title: Text(prod.nombre),
            subtitle: Text("${prod.precioUd.toStringAsFixed(2)} €"),
            trailing: SizedBox(
              width: 130,
              child: Row(
                children: [
                  //boton restar prod
                  /// Botón para disminuir la cantidad del producto seleccionado.
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
                  /// Muestra la cantidad actual del producto seleccionado.
                  Expanded(child: Center(child: Text(cantidad.toString()))),

                  //boton sumar prod
                  /// Botón para aumentar la cantidad del producto seleccionado.
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
                  /// Botón para eliminar el producto seleccionado de la lista.
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

      /// Barra inferior con botones para cancelar o añadir productos.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Botón para cancelar la operación y volver atrás.
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 219, 82, 58),
                      foregroundColor: Colors.black
                    ),
              child: const Text("Cancelar")
            ),
            /// Botón para añadir los productos seleccionados y volver atrás.
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