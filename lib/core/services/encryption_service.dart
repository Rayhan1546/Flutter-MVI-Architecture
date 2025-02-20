import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_repo_list/core/mixin/encryption_mixin.dart';

class EncryptionService with EncryptionMixIn {
  String decryptEnvValue({required String envKey}) {
    final encryptedValue = dotenv.env[envKey] ?? '';

    return decrypt(encryptedValue: encryptedValue);
  }
}
