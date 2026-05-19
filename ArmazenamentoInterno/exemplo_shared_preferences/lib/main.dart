import 'package:flutter/material.dart';
import 'package:exemplo_shared_preferences/view/home_page.dart';
import 'package:exemplo_shared_preferences/view/exemplo1_page.dart';
import 'package:exemplo_shared_preferences/view/exemplo2_page.dart';
import 'package:exemplo_shared_preferences/view/exemplo3_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<bool> darkModeNotifier = ValueNotifier(false);

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  darkModeNotifier.value = prefs.getBool("darkMode") ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: darkModeNotifier,
      builder: (context, darkMode, child) {
        return MaterialApp(
          routes: {
            "/tela1": (context) => const Exemplo1Page(),
            "/tela2": (context) => const Exemplo2Page(),
            "/tela3": (context) => const Exemplo3Page(),
          },
          home: const HomePage(),
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(0, 0, 0, 0),
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6CC070),
              brightness: Brightness.dark,
            ),
          ),
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
