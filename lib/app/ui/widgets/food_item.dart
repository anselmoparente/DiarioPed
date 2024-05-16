import 'package:flutter/material.dart';
import 'package:diarioped/app/ui/theme/design_system.dart';

class FoodItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isWarning;

  const FoodItem({
    required this.title,
    required this.description,
    required this.isWarning,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: DiariopedColors.itemText,
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
        ),
        Offstage(
          offstage: !isWarning,
          child: const Icon(
            Icons.warning,
            size: 32.0,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
