import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';
import 'package:application_bar_ud4/viewmodels/pedidoViewModel.dart';
import 'pagPedido.dart';

/// Página principal de la aplicación que muestra la lista de pedidos y permite crear nuevos pedidos.
/// Parámetros:
/// - [viewModel]: El ViewModel que gestiona la lógica de los pedidos.
class Pagprincipal extends StatefulWidget {

  /// ViewModel que gestiona la lógica de los pedidos.
  final Pedidoviewmodel viewModel;

  /// Constructor de la clase Pagprincipal.
  const Pagprincipal({super.key, required this.viewModel});

  
  @override
  State<Pagprincipal> createState() => _PagprincipalState();
}

/// Estado de la página principal.
/// Gestiona la lista de pedidos y la interfaz de usuario.
class _PagprincipalState extends State<Pagprincipal> {

  /// Lista de pedidos existentes.
  List<Pedido> listaPedidos = [];

  //cargamos los pedidos iniciales
  /// Inicializa el estado de la página.
  @override
  void initState() {
    super.initState();

    listaPedidos = widget.viewModel.listaPedidos;
  }

  @override
  Widget build(BuildContext context) {

    /// Construye la interfaz de usuario de la página principal.
    /// Muestra la lista de pedidos y un botón para crear nuevos pedidos.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(66, 83, 196, 177),
        title: Text("MoMo´s Bar"),
        centerTitle: true,
      ),
      body: Center(
        
        
        child: AnimatedBuilder(
          animation: widget.viewModel,
          builder: (context, _) {

            return Column(
              children: [
                /// Contenedor que muestra la lista de pedidos.
                /// Cada pedido muestra la mesa, el total de productos y el precio total.
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Column(
                    children: [
                      const Text("Lista de Pedidos"),

                      const SizedBox(height: 10),

                      /// Lista de pedidos mostrada en un ListView.
                      /// Cada pedido se representa como una tarjeta con información relevante.
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: listaPedidos.length,
                          itemBuilder: (context, i) {
                            final pedi = listaPedidos[i];
                            return Card(
                              child: ListTile(
                                title: Text("Mesa ${pedi.mesa}, ${pedi.totalProductos} Uds, Total: ${pedi.precioTotal.toStringAsFixed(2)} €")
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child:Tooltip(
                  message: 'Crear un nuevo pedido',
                  child: 
                    /// Botón para crear un nuevo pedido.
                    ElevatedButton(
                      onPressed: () async {
                        final pedidoNuevo = await Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => PagPedido(viewModel: widget.viewModel),
                            ),
                        );

                        if(pedidoNuevo !=null && mounted) {
                          widget.viewModel.anadirPedido(pedidoNuevo);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black
                      ),
                      child: const Text("Nuevo Pedido")
                    ),
                  ),  
                ),
              ],
            );
          },
        ),
      ),
      
     /* floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pedidoNuevo = await Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => PagPedido(viewModel: widget.viewModel),
              ),
          );

          if(pedidoNuevo !=null && mounted) {
            widget.viewModel.anadirPedido(pedidoNuevo);
          }
        },
        tooltip: 'Nuevo Pedido',
        child: const Text("Nuevo Pedido"),
      ),*/
    );
  }
}