import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';
import 'package:application_bar_ud4/viewmodels/pedidoViewModel.dart';
import 'package:application_bar_ud4/views/pagPrincipal.dart';
import 'package:application_bar_ud4/views/pagVerResumenPedido.dart';


void main() {
  final pedidoVM = Pedidoviewmodel();
  runApp(MyApp(viewModel: pedidoVM));
}

class MyApp extends StatelessWidget {
  final Pedidoviewmodel viewModel;
  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoMo´s Bar',
      debugShowCheckedModeBanner: false,
      home: Pagprincipal(viewModel: viewModel),
      routes: {
        '/resumen': (context) {
          final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;
          return PagVerResumenPedido(pedido: pedido);
        }
      },
    );
  }
}
