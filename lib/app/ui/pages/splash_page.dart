import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/data/controller/init_controller.dart';
import 'package:nutriped/app/data/services/auth_service.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
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
      const Duration(seconds: 3),
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'DiarioPed',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: NutripedColors.itemText,
              ),
            ),
            Image.asset(
              'assets/images/splash_icon.png',
              height: size.width * 0.9,
              width: size.width * 0.9,
            ),
            const Text(
              'Autores',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: NutripedColors.itemText,
              ),
            ),
            const Text(
              'Francisco Xavier Paranhos Coêlho Simões',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Morgana Gradvohl',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Ana Carolina Del-Sarto Azevedo Maia',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Nilton César Nogueira dos Santos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Carla Figueiredo Brandão',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
