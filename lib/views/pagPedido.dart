import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';
import 'package:application_bar_ud4/models/productoPedido.dart';
import 'package:application_bar_ud4/viewmodels/pedidoViewModel.dart';
import 'pagAnadirProductos.dart';
import 'package:flutter/services.dart';

/// Página para crear un nuevo pedido.
/// Permite introducir el número de mesa y añadir productos al pedido.
/// Parámetros:
/// - [viewModel]: El ViewModel que gestiona la lógica de los pedidos.
class PagPedido extends StatefulWidget {

  /// ViewModel que gestiona la lógica de los pedidos.
  final Pedidoviewmodel viewModel;

  /// Constructor de la clase PagPedido.
  const PagPedido({super.key, required this.viewModel});

  @override
  State<PagPedido> createState() => _PagPedidoState();

}

/// Estado de la página para crear un nuevo pedido.
/// Gestiona la entrada del número de mesa y la selección de productos.
class _PagPedidoState extends State<PagPedido> {

  /// Controlador para el campo de texto del número de mesa.
  final TextEditingController mesaControler = TextEditingController();

  /// Lista de productos seleccionados para el pedido.
  List<ProductoPedido> produSelec = [];

  /// Calcula el total de productos y el precio total del pedido.
  int get prodTotal => produSelec.fold(0,(sum, pro) => sum + pro.cantidad);

  /// Calcula el precio total del pedido.
  double get precTotal => produSelec.fold(0.0, (sum, pro) => sum + pro.precioProdPorUds);

  @override
  Widget build(BuildContext context) {
    /// Construye la interfaz de usuario de la página para crear un nuevo pedido.
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Pedido"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// Campo de texto para introducir el número de mesa.
            TextField(
              controller: mesaControler,
              keyboardType: TextInputType.number,
              /// InputFormatters para validar que solo se introduzcan números y limitar la longitud a 2 caracteres.
              /// FilteringTextInputFormatter.digitsOnly bloquea la entrada de letras, puntos y comas.
              /// LengthLimitingTextInputFormatter(2) bloquea que se escriban más de 2 números.
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Bloquea letras, puntos y comas
                LengthLimitingTextInputFormatter(2),    // Bloquea que se escriban más de 2 números
              ],
              decoration: const InputDecoration(
                labelText: "Número de mesa:",
                hintText: "Ejemplo: 1",
                helperText: "Introduce el número de mesa para el pedido",
                ),
              

            ),

            const SizedBox(height: 10),

            /// Botón para añadir productos al pedido.
            Tooltip(
              message: "Añadir productos al pedido",
              child:ElevatedButton(
                onPressed: () async{
                  final seleccion = await Navigator.push<List<ProductoPedido>>(
                    context, MaterialPageRoute(
                      builder: (_) => PagAnadirProducto(
                        productosSelec: produSelec,
                        viewModel: widget.viewModel
                      ),
                    ),
                  );

                  /// Actualiza la lista de productos seleccionados si se ha hecho una selección.
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
            ),
            

            const SizedBox(height: 10),

            /// Muestra un resumen del pedido con los productos añadidos, total de unidades y precio total.
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

            /// Botón para ver el resumen del pedido.
            Tooltip(
              message: "Ver resumen del pedido actual",
              child: ElevatedButton(
                onPressed: () {
                  /// Validación para asegurarse de que se han seleccionado productos y una mesa antes de mostrar el resumen del pedido.
                  if(produSelec.isEmpty || mesaControler.text.isEmpty) {
                    return mostrarError('Para ver resumen, ha de tener productos añadidos y una mesa seleccionada');
                    }

                  /// Si la validación es correcta, se navega a la página de resumen del pedido pasando el pedido como argumento.
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
            ),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 10),

            /// Barra inferior con botones para cancelar o añadir el pedido.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// Botón para cancelar el pedido.
                Tooltip(
                  message: 'Cancelar la creación del pedido actual',
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 219, 82, 58),
                        foregroundColor: Colors.black
                      ),
                    child: const Text("Cancelar")
                  ),
                ),

                /// Botón para añadir el pedido.
                Tooltip(
                  message: 'Añadir el pedido actual',
                  child: ElevatedButton(
                    onPressed: () {
                      /// Validación para asegurarse de que se han seleccionado productos y una mesa antes de añadir el pedido.
                    if(produSelec.isEmpty && mesaControler.text.isEmpty) {
                      return mostrarError('Por favor, selecciona productos y una mesa');
                    }
                    /// Validación para asegurarse de que se han seleccionado productos antes de añadir el pedido.
                    else if(produSelec.isEmpty) {
                      return mostrarError('Por favor, selecciona productos');
                    }
                    /// Validación para asegurarse de que se ha seleccionado una mesa antes de añadir el pedido.
                    else if(mesaControler.text.isEmpty) {
                      return mostrarError('Por favor, selecciona una mesa');
                    }

                    /// Si la validación es correcta, se cierra la página y se devuelve el pedido creado al llamar a Navigator.pop con el pedido como argumento.
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  /// Muestra un mensaje de error en un SnackBar.
  /// Parámetros:
  /// - [mensaje]: El mensaje de error a mostrar.
  void mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.redAccent),
    );
  }

}