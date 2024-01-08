import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/ui/widgets/custom_button.dart';

class AccessPage extends StatelessWidget {
  const AccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.15,
              child: Image.asset('assets/images/splash_icon.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.075),
              child: const Text(
                'Como você se qualifica?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.8,
              child: CustomButton(
                text: 'Sou um paciente',
                prefixIcon: Icons.person,
                onPressed: () => context.go('/login'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: size.width * 0.8,
              child: CustomButton(
                text: 'Sou um dentista',
                prefixIcon: Icons.medication,
                onPressed: () => context.go('/login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
