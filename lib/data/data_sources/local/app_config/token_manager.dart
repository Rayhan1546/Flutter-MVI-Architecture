import 'dart:convert';
import 'package:github_repo_list/core/mixin/encryption_mixin.dart';
import 'package:github_repo_list/data/data_sources/local/app_config/config_manager.dart';
import 'package:github_repo_list/domain/entities/login_credentials.dart';

class TokenManager extends ConfigManager<String> with EncryptionMixIn {
  @override
  String get key => 'server_tokens';

  Future<void> saveLoginToken({
    required LoginCredentials loginCredential,
  }) async {
    final jsonString = jsonEncode(loginCredential.toJson());

    final encryptedJsonString = encrypt(value: jsonString);

    await saveValue(encryptedJsonString);
  }

  Future<LoginCredentials?> getLoginCredential() async {
    final encryptedJsonString = await getValue();

    if (encryptedJsonString == null) return null;

    final jsonString = decrypt(encryptedValue: encryptedJsonString);

    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return LoginCredentials.fromJson(jsonData);
  }
}
