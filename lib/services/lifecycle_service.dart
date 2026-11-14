
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifecycleService extends WidgetsBindingObserver {
  final ValueNotifier<String> estado =
      ValueNotifier('Aplicativo iniciado');

  final ValueNotifier<String> ultimoHorario =
      ValueNotifier('Nenhum horário salvo');

  void iniciar() {
    WidgetsBinding.instance.addObserver(this);
    carregarHorario();
  }

  Future<void> carregarHorario() async {
    final prefs = await SharedPreferences.getInstance();

    ultimoHorario.value =
        prefs.getString('ultimoHorario') ??
        'Nenhum horário salvo';
  }

  Future<void> salvarHorario() async {
    final prefs = await SharedPreferences.getInstance();

    final agora = DateTime.now();

    final horario =
        '${agora.day}/${agora.month}/${agora.year} '
        '${agora.hour}:${agora.minute}';

    await prefs.setString('ultimoHorario', horario);

    ultimoHorario.value = horario;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      estado.value = 'Aplicativo em Background';
      salvarHorario();
    }

    if (state == AppLifecycleState.resumed) {
      estado.value = 'Aplicativo em Foreground';
      carregarHorario();
    }
  }

  void finalizar() {
    WidgetsBinding.instance.removeObserver(this);
    estado.dispose();
    ultimoHorario.dispose();
  }
}
