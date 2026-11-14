
import 'package:flutter/material.dart';

class PedidoPage extends StatelessWidget {
  final String pedidoId;

  const PedidoPage({
    super.key,
    required this.pedidoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pedido'),
      ),
      body: Center(
        child: Text(
          'Pedido: $pedidoId',
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
