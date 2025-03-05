class LoginCredentials {
  final String token;
  final String refreshToken;
  final String userName;

  LoginCredentials({
    required this.token,
    required this.refreshToken,
    required this.userName,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'username': userName,
    };
  }

  factory LoginCredentials.fromJson(Map<String, dynamic> json) {
    return LoginCredentials(
      token: json['token'],
      refreshToken: json['refreshToken'],
      userName: json['username'],
    );
  }
}
