import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/data/services/auth_service.dart';
import 'package:nutriped/app/ui/pages/home_page.dart';
import 'package:nutriped/app/ui/pages/login_page.dart';
import 'package:nutriped/app/ui/pages/access_page.dart';
import 'package:nutriped/app/ui/pages/register_page.dart';
import 'package:nutriped/app/ui/pages/splash_page.dart';
import 'package:nutriped/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
      routes: [
        GoRoute(
          path: 'access',
          name: '/access',
          builder: (context, state) => const AccessPage(),
        ),
        GoRoute(
          path: 'home',
          name: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: 'login',
          name: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: 'register',
          name: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
