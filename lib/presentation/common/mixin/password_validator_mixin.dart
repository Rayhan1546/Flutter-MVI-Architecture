import 'package:github_repo_list/presentation/common/enum/validation_error.dart';

mixin PasswordValidatorMixIn {
  ValidationError? getPasswordValidationError(String? password) {
    if (password == null) return null;
    if (password.isEmpty) return ValidationError.passwordEmpty;
    if (password.contains(' ')) {
      return ValidationError.passwordContainsSpace;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return ValidationError.passwordNoLowercase;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return ValidationError.passwordNoUppercase;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return ValidationError.passwordNoDigit;
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return ValidationError.passwordNoSpecialChar;
    }
    if (password.length < 8) {
      return ValidationError.passwordTooShort;
    }
    return null;
  }

  ValidationError? matchTwoPassword(
    String? password1,
    String? password2,
  ) {
    if (password1 == null || password2 == null) return null;
    if (password2.isEmpty) return ValidationError.passwordEmpty;
    if (password1 != password2) return ValidationError.passwordNotMatched;
    return null;
  }

  bool isValid(String? password) {
    if (password == null) return false;
    return getPasswordValidationError(password) == null;
  }
}
