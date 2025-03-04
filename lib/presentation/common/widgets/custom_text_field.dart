import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { email, password, number, text }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String textFieldName;
  final String? errorText;
  final bool? enable;
  final ValueChanged<String>? onChanged;
  final TextFieldType textFieldType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.textFieldName,
    this.errorText,
    this.enable = true,
    this.onChanged,
    this.textFieldType = TextFieldType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    super.dispose();
  }

  TextInputType _getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.password:
      case TextFieldType.text:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.textFieldType) {
      case TextFieldType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      default:
        return null;
    }
  }

  void _flipVisibilityIcon() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  Widget? _getSuffixIcon(ThemeData theme) {
    if (widget.textFieldType == TextFieldType.password) {
      return ValueListenableBuilder<bool>(
        valueListenable: _isPasswordVisible,
        builder: (context, isVisible, _) {
          return IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: widget.enable == false ? theme.disabledColor : null,
            ),
            onPressed: widget.enable == false ? null : _flipVisibilityIcon,
          );
        },
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: _isPasswordVisible,
      builder: (context, isVisible, _) {
        return TextFormField(
          controller: widget.controller,
          enabled: widget.enable,
          obscureText: widget.textFieldType == TextFieldType.password
              ? !isVisible
              : false,
          onChanged: widget.onChanged,
          keyboardType: _getKeyboardType(),
          inputFormatters: _getInputFormatters(),
          decoration: InputDecoration(
            labelText: widget.textFieldName,
            labelStyle: TextStyle(
              color: widget.enable == false ? theme.disabledColor : null,
              fontSize: 16,
            ),
            errorText: widget.errorText,
            suffixIcon: _getSuffixIcon(theme),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: widget.enable == false
                ? theme.colorScheme.surfaceContainerHighest
                : null,
          ),
          style: TextStyle(
            fontSize: 16,
            color: widget.enable == false ? theme.disabledColor : null,
          ),
          cursorColor: theme.colorScheme.primary,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
