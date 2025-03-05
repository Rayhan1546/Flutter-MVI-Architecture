import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final double height;
  final Color? borderColor;
  final Color? textColor;
  final bool isLoading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double borderWidth;
  final bool disabled;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = true,
    this.height = 48.0,
    this.borderColor,
    this.textColor,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius = 12.0,
    this.padding,
    this.borderWidth = 1.5,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final finalBorderColor = borderColor ?? colorScheme.primary;
    final finalTextColor = textColor ?? colorScheme.primary;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: OutlinedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: finalTextColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color: disabled ? finalBorderColor.withAlpha(100) : finalBorderColor,
            width: borderWidth,
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(finalTextColor),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}