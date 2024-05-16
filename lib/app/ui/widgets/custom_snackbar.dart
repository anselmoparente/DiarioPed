import 'package:flutter/material.dart';
import 'package:diarioped/app/ui/theme/design_system.dart';

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar(
    this.context,
  );

  void show({
    required String message,
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        backgroundColor: DiariopedColors.primary4,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: Text(
          message,
          softWrap: true,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
