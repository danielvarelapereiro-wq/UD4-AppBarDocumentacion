import 'package:flutter/material.dart';
import 'package:application_bar_ud4/models/pedido.dart';
import 'package:application_bar_ud4/models/producto.dart';
import 'package:application_bar_ud4/models/productoPedido.dart';

class Pedidoviewmodel extends ChangeNotifier{

  //Inicializamos los Productos

final List<Producto> listaProductos = [
  Producto(id: 1, nombre: "Estrella 1906", precioUd: 3.50),
  Producto(id: 2, nombre: "1/3 Estrella", precioUd: 3.00),
  Producto(id: 3, nombre: "Coca-Cola", precioUd: 2.50),
  Producto(id: 4, nombre: "Coca-Cola Zero", precioUd: 2.60),
  Producto(id: 5, nombre: "1/3 Estrella", precioUd: 3.00),
  Producto(id: 6, nombre: "Botella de Agua", precioUd: 2.20),
  Producto(id: 7, nombre: "Hamburguesa Completa", precioUd: 7.50),
  Producto(id: 8, nombre: "Hamburguesa Simple", precioUd: 5.25),
  Producto(id: 9, nombre: "Sandwich Mixto", precioUd: 3.75),
  Producto(id: 10, nombre: "Sandwich Vegetal", precioUd: 3.50),
];

  //Inicializamos nuestros pedidos iniciales
  late List<Pedido> listaPedidos;

  Pedidoviewmodel() {
    listaPedidos = [
      Pedido(mesa: 1, productos: [ProductoPedido(producto: listaProductos[0], cantidad: 2),
                                  ProductoPedido(producto: listaProductos[6], cantidad: 2)]),

      Pedido(mesa: 2, productos: [ProductoPedido(producto: listaProductos[2], cantidad: 2),
                                  ProductoPedido(producto: listaProductos[7], cantidad: 2)]),

      Pedido(mesa: 3, productos: [ProductoPedido(producto: listaProductos[5], cantidad: 1),
                                  ProductoPedido(producto: listaProductos[9], cantidad: 2)])                           
    ];
  }

  void anadirPedido(Pedido pedi) {
    listaPedidos.add(pedi);
    notifyListeners();
  }

  

}