import 'package:flutter/material.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';

class FoodItem extends StatelessWidget {
  final String title;
  final String description;

  const FoodItem({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            color: NutripedColors.itemText,
          ),
        ),
        Text(
          description != '' ? description : 'Sem observação',
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
