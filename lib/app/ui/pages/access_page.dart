import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:nutriped/app/ui/widgets/custom_button.dart';

class AccessPage extends StatelessWidget {
  const AccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: NutripedColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.2,
              child: Image.asset('assets/images/splash_icon.png'),
            ),
            const Text(
              'Como você se qualifica?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: NutripedColors.text,
              ),
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              width: size.width * 0.8,
              child: CustomButton(
                text: 'Sou um paciente',
                prefixIcon: Icons.person,
                onPressed: () => GoRouter.of(context).pushNamed('/login'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: size.width * 0.8,
              child: CustomButton(
                text: 'Sou um dentista',
                prefixIcon: Icons.medication,
                onPressed: () => GoRouter.of(context).pushNamed('/login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
