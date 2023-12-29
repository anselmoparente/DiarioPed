import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                color: Colors.indigo[900],
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
