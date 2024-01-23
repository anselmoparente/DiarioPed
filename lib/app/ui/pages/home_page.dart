import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: NutripedColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NutripedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.white,
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text(
          'DashBoard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: IntrinsicHeight(
          child: Column(
            children: [
              const Icon(
                Icons.group_off,
                size: 108.0,
                color: NutripedColors.icon,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: size.width * 0.8,
                child: const Text(
                  'No momento, ainda não existe nenhum paciente vinculado!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: NutripedColors.text),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
