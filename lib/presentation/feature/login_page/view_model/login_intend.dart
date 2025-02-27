abstract class LoginIntent {
  const LoginIntent();
}

class LoginEmailIntent extends LoginIntent {
  final String? email;
  const LoginEmailIntent({required this.email});
}

class LoginPasswordIntent extends LoginIntent {
  final String? password;
  const LoginPasswordIntent({required this.password});
}

class LoginButtonIntent extends LoginIntent {
  const LoginButtonIntent();
}
