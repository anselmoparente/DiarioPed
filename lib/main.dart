import 'package:flutter/material.dart';
import 'package:nutriped/app/ui/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
