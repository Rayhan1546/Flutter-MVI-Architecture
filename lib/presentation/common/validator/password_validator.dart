import 'package:github_repo_list/presentation/common/enum/validation_error.dart';

class PasswordValidator {
  static ValidationError getPasswordValidation(String password) {
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
    return ValidationError.none;
  }

  static ValidationError matchTwoPassword(
    String password1,
    String password2,
  ) {
    if (password2.isEmpty) return ValidationError.passwordEmpty;
    if (password1 != password2) return ValidationError.passwordNotMatched;
    return ValidationError.none;
  }
}
