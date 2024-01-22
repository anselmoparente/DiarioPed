import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NutripedColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text('DashBoard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Icon(
                Icons.group_off,
                size: 124.0,
                color: NutripedColors.button,
              ),
              Text(
                'No momento, ainda não existe nenhum paciente cadastrado!',
                style: TextStyle(fontSize: 24.0, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
