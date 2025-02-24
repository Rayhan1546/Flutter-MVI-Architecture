import 'package:github_repo_list/core/mixin/encryption_mixin.dart';
import 'package:github_repo_list/data/data_sources/local/app_config/config_manager.dart';
import 'package:github_repo_list/domain/entities/login_credentials.dart';

class TokenManager extends ConfigManager<Map<String, dynamic>> with EncryptionMixIn {
  @override
  String get key => 'server_tokens';

  Future<void> saveLoginToken({
    required String token,
    required String refreshToken,
    required String userName,
  }) async {
    final data = {
      'token': encrypt(value: token),
      'refreshToken': encrypt(value: refreshToken),
      'username': encrypt(value: userName),
    };

    print(data);

    await saveValue(data);
  }

  Future<LoginCredentials?> getLoginCredential() async {
    final data = await getValue();
    if (data == null) return null;

    return LoginCredentials(
      token: decrypt(encryptedValue: data['token']),
      refreshToken: decrypt(encryptedValue: data['refreshToken']),
      userName: decrypt(encryptedValue: data['username']),
    );
  }
}
