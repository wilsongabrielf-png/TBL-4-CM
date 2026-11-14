
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/message.dart';

class ChatService {
  static const String chave = 'mensagens';

  Future<void> salvar(List<ChatMessage> mensagens) async {
    final prefs = await SharedPreferences.getInstance();

    final lista = mensagens
        .map((mensagem) => mensagem.toJson())
        .toList();

    await prefs.setString(
      chave,
      jsonEncode(lista),
    );
  }

  Future<List<ChatMessage>> carregar() async {
    final prefs = await SharedPreferences.getInstance();

    final dados = prefs.getString(chave);

    if (dados == null) {
      return [];
    }

    final lista = jsonDecode(dados) as List;

    return lista
        .map((item) => ChatMessage.fromJson(item))
        .toList();
  }
}
