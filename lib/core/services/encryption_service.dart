import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_repo_list/core/encryption/encryption_algorithm.dart';

class EncryptionService {
  EncryptionService._internal();

  static final EncryptionService _instance = EncryptionService._internal();

  factory EncryptionService() => _instance;

  String decryptEnvValue({required String envKey}) {
    final encryptedValue = dotenv.env[envKey] ?? '';

    return EncryptionAlgorithm().decrypt(encryptedValue);
  }
}
