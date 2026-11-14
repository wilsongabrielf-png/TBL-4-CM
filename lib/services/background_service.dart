
import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

const tarefaSincronizacao = 'sincronizarDados';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (task == tarefaSincronizacao) {
      debugPrint('Iniciando sincronização...');

      await Future.delayed(
        const Duration(seconds: 3),
      );

      debugPrint('Sincronização concluída!');
    }

    return true;
  });
}

class BackgroundService {
  static Future<void> iniciar() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    await Workmanager().registerPeriodicTask(
      'syncTask',
      tarefaSincronizacao,
      frequency: const Duration(minutes: 15),
    );
  }
}
