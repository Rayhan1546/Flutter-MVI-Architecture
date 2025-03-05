import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double elevation;
  final bool disabled;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = true,
    this.height = 48.0,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius = 12.0,
    this.padding,
    this.elevation = 0,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary,
          foregroundColor: foregroundColor ?? colorScheme.onPrimary,
          elevation: elevation,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBackgroundColor: colorScheme.primary.withAlpha(100),
          disabledForegroundColor: colorScheme.onPrimary.withAlpha(150),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
