import 'package:github_repo_list/data/data_sources/local/app_config/config_manager.dart';
import 'package:github_repo_list/domain/entities/login_credentials.dart';

class TokenManager extends ConfigManager<Map<String, dynamic>> {
  @override
  String get key => 'server_tokens';

  Future<void> saveLoginToken({
    required LoginCredentials loginCredential,
  }) async {
    final jsonString = loginCredential.toJson();

    await saveValue(jsonString);
  }

  Future<LoginCredentials?> getLoginCredential() async {
    final json = await getValue();

    if (json == null) return null;

    return LoginCredentials.fromJson(json);
  }
}
