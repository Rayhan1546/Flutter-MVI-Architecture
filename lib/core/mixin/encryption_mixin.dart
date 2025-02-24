import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_repo_list/core/encryption/encryption_algorithm.dart';

mixin EncryptionMixIn {
  final encryptService = EncryptionAlgorithm.instance;

  String encrypt({required String value}) {
    return encryptService.encrypt(value);
  }

  String decrypt({required String encryptedValue}) {
    return encryptService.decrypt(encryptedValue);
  }

  String decryptEnvValue({required String envKey}) {
    final encryptedValue = dotenv.env[envKey] ?? '';

    print(encryptedValue);

    return encryptService.decrypt(encryptedValue);
  }
}
