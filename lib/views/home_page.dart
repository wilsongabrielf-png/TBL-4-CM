
import 'package:flutter/material.dart';
import '../services/lifecycle_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LifecycleService lifecycle = LifecycleService();

  @override
  void initState() {
    super.initState();
    lifecycle.iniciar();
  }

  @override
  void dispose() {
    lifecycle.finalizar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 2 - Persistência'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: lifecycle.estado,
              builder: (context, estado, child) {
                return Text(
                  estado,
                  style: const TextStyle(fontSize: 22),
                );
              },
            ),

            const SizedBox(height: 30),

            const Text('Último horário salvo:'),

            ValueListenableBuilder<String>(
              valueListenable: lifecycle.ultimoHorario,
              builder: (context, horario, child) {
                return Text(
                  horario,
                  style: const TextStyle(fontSize: 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
