import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/data/controller/init_controller.dart';
import 'package:nutriped/app/data/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final InitController _controller = InitController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future.delayed(
      const Duration(seconds: 2),
      () => _controller.tryLogin(auth: context.read<AuthService>()).then(
        (value) {
          if (value.$1) {
            if (value.$2 == 'patient') {
              GoRouter.of(context).pushReplacementNamed('/patient');
            } else {
              GoRouter.of(context).pushReplacementNamed('/home');
            }
          } else {
            GoRouter.of(context).pushReplacementNamed('/access');
          }
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nutriped',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            Image.asset(
              'assets/images/splash_icon.png',
              height: size.width * 0.9,
              width: size.width * 0.9,
            ),
          ],
        ),
      ),
    );
  }
}
