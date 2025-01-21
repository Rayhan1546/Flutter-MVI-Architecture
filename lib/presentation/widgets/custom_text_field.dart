import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String textFieldName;
  final String? errorText;
  final bool? enable;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.textFieldName,
    this.errorText,
    this.enable = true,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  // Material Design colors
  final Color _primaryColor = const Color(0xFF6200EE);    // Purple 500
  final Color _labelColor = const Color(0xFF666666);      // Grey 700
  final Color _errorColor = const Color(0xFFB00020);      // Error red
  final Color _textColor = const Color(0xFF121212);       // Almost black
  final Color _borderColor = const Color(0xFFE0E0E0);     // Grey 300
  final Color _focusedBorderColor = const Color(0xFF6200EE); // Purple 500

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enable,
      obscureText: !_isPasswordVisible,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.textFieldName,
        labelStyle: TextStyle(
          color: widget.enable == false ? Colors.grey : _labelColor,
          fontSize: 16,
        ),
        errorText: widget.errorText,
        errorStyle: TextStyle(
          color: _errorColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: widget.enable == false ? Colors.grey : _labelColor,
          ),
          onPressed: widget.enable == false
              ? null
              : () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _focusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _errorColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: widget.enable == false
            ? Colors.grey.shade100
            : Colors.white,
      ),
      style: TextStyle(
        fontSize: 16,
        color: widget.enable == false ? Colors.grey : _textColor,
      ),
      cursorColor: _primaryColor,
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
    );
  }
}