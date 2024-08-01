import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool? noHaveLabel;
  final bool? obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? suffixIconOnPressed;
  final void Function(String)? onChanged;
  final bool? readOnly;

  const CustomTextFormField({
    required this.controller,
    required this.label,
    this.hint,
    this.noHaveLabel,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.onChanged,
    this.readOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: InputBorder.none,
        label: noHaveLabel == true ? null : Text(label),
        hintText: hint ?? label,
        hintStyle: const TextStyle(
          fontSize: 17,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 20,
                color: Colors.grey,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? TextButton(
                onPressed: () => suffixIconOnPressed,
                style: const ButtonStyle(
                  overlayColor:
                      WidgetStatePropertyAll<Color>(Colors.transparent),
                ),
                child: Icon(
                  suffixIcon,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
      cursorColor: Colors.blue.shade900,
      onChanged: onChanged,
    );
  }
}
