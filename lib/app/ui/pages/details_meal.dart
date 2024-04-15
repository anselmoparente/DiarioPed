import 'package:flutter/material.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';

class DetailsMeal extends StatelessWidget {
  const DetailsMeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NutripedColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NutripedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalhes da refeição',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
