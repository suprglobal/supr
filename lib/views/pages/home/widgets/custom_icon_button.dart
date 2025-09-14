import 'package:flutter/material.dart';
import 'package:superapp/constants/global_variables.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? iconColor;
  final double borderRadius;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding; // Custom padding
  final double? iconSize;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.width,
    this.height,
    this.buttonColor,
    this.iconColor,
    this.borderRadius = 10.0,
    this.padding,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 50, // Default width if not provided
      height: height ?? 50, // Default height if not provided
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            buttonColor ?? colorScheme(context).primary,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          padding: WidgetStateProperty.all(
            padding ?? const EdgeInsets.all(8),
          ), // Default padding if not provided
        ),
        onPressed: onPressed,
        child: Icon(
          icon,
          size: iconSize ?? 24, // Default icon size
          color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
