
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';

import 'services/background_service.dart';
import 'services/notification_service.dart';
import 'services/navigation_service.dart';

import 'views/home_page.dart';

// Handler para notificações recebidas em background
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('Notificação recebida em background');
  debugPrint(message.notification?.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Registrar handler de notificações
  FirebaseMessaging.onBackgroundMessage(
    firebaseBackgroundHandler,
  );

  // Inicializar WorkManager
  await BackgroundService.iniciar();

  // Inicializar notificações
  final notificationService = NotificationService();
  await notificationService.iniciar();

  // Executar aplicativo
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Mobile Background',

      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),

      navigatorKey: navigatorKey,

      home: const HomePage(),
    );
  }
}
