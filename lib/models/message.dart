
class ChatMessage {
  final String texto;
  final DateTime horario;

  ChatMessage({
    required this.texto,
    required this.horario,
  });

  Map<String, dynamic> toJson() {
    return {
      'texto': texto,
      'horario': horario.toIso8601String(),
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      texto: json['texto'],
      horario: DateTime.parse(json['horario']),
    );
  }
}
