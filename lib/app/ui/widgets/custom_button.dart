import 'package:flutter/material.dart';
import 'package:diarioped/app/ui/theme/design_system.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData? prefixIcon;
  final bool? isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const CustomButton({
    required this.onPressed,
    required this.text,
    this.prefixIcon,
    this.isLoading,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? DiariopedColors.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: borderColor != null
                ? BorderSide(width: 2.0, color: borderColor!)
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (prefixIcon != null)
                ? Container(
                    margin: EdgeInsets.only(
                      left: (prefixIcon != null) ? 12 : 0,
                    ),
                    child: Icon(
                      prefixIcon,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  )
                : Container(),
            (isLoading == true)
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      left: (prefixIcon != null) ? 24 : 0,
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
