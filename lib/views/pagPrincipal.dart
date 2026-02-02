import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';
import 'package:application_bar_ud4/viewmodels/pedidoViewModel.dart';
import 'pagPedido.dart';

class Pagprincipal extends StatefulWidget {

  final Pedidoviewmodel viewModel;

  const Pagprincipal({super.key, required this.viewModel});

  @override
  State<Pagprincipal> createState() => _PagprincipalState();
}

class _PagprincipalState extends State<Pagprincipal> {

  List<Pedido> listaPedidos = [];

  //cargamos los pedidos iniciales
  @override
  void initState() {
    super.initState();

    listaPedidos = widget.viewModel.listaPedidos;
  }

  @override
  Widget build(BuildContext context) {

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

                Center(child: 
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