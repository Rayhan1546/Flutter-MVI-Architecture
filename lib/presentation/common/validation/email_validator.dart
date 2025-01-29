import 'package:github_repo_list/presentation/common/validation/validation_error.dart';

class EmailValidator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static ValidationError? getValidationError(String? email) {
    if (email == null) return null;
    if (email.isEmpty) return ValidationError.invalidEmail;
    if (email.contains(' ')) return ValidationError.invalidEmail;
    if (!email.contains('@')) return ValidationError.invalidEmail;
    if (!_emailRegExp.hasMatch(email)) return ValidationError.invalidEmail;
    return null;
  }
}
