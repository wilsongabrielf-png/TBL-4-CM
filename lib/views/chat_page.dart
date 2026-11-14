
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService service = ChatService();

  final TextEditingController controller =
      TextEditingController();

  List<ChatMessage> mensagens = [];

  @override
  void initState() {
    super.initState();
    carregarMensagens();
  }

  Future<void> carregarMensagens() async {
    final resultado = await service.carregar();

    if (!mounted) return;

    setState(() {
      mensagens = resultado;
    });
  }

  Future<void> enviarMensagem() async {
    final texto = controller.text.trim();

    if (texto.isEmpty) return;

    setState(() {
      mensagens.add(
        ChatMessage(
          texto: texto,
          horario: DateTime.now(),
        ),
      );
    });

    controller.clear();

    await service.salvar(mensagens);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mensagens.length,
              itemBuilder: (context, index) {
                final mensagem = mensagens[index];

                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(mensagem.texto),
                  subtitle: Text(
                    mensagem.horario.toString(),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma mensagem',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                IconButton(
                  onPressed: enviarMensagem,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
