import 'package:flutter/material.dart';
import 'screens/splash.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  bool temaEscuro = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abastecimentos',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF1F1F1),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF555555),
          surface: Color(0xFFFFFFFF),
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF181818),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFBDBDBD),
          surface: Color(0xFF242424),
        ),
      ),

      themeMode: temaEscuro
          ? ThemeMode.dark
          : ThemeMode.light,

      home: SplashScreen(
        temaEscuro: temaEscuro,
        mudarTema: (valor) {
          setState(() {
            temaEscuro = valor;
          });
        },
      ),
    );
  }
}