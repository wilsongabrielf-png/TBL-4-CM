
import 'package:flutter/material.dart';
import '../views/pedido_page.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();

void abrirPedido(String pedidoId) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (_) => PedidoPage(
        pedidoId: pedidoId,
      ),
    ),
  );
}
