import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/ui/pages/login_page.dart';
import 'package:nutriped/app/ui/pages/access_page.dart';
import 'package:nutriped/app/ui/pages/splash_page.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'access',
          builder: (context, state) => const AccessPage(),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
