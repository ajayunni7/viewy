import 'package:flutter/material.dart';

import 'package:viewy_test/core/api_service.dart';
import 'package:viewy_test/features/auth/presentation/login_screen.dart';
import 'package:viewy_test/splash/splash_screen.dart';
import 'package:viewy_test/features/notes/presentation/notes_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService().loadPersistedToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viewy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const NotesListScreen(),
      },
    );
  }
}
