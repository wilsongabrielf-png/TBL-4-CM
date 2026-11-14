
import 'package:firebase_messaging/firebase_messaging.dart';
import 'navigation_service.dart';

class NotificationClickService {
  void configurarCliques() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final pedidoId = message.data['pedidoId'];

      if (pedidoId != null) {
        abrirPedido(pedidoId.toString());
      }
    });
  }

  Future<void> verificarNotificacaoInicial() async {
    final message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      final pedidoId = message.data['pedidoId'];

      if (pedidoId != null) {
        abrirPedido(pedidoId.toString());
      }
    }
  }
}
