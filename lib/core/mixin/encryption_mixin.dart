import 'package:github_repo_list/core/encryption/encryption_algorithm.dart';

mixin EncryptionMixIn {
  final encryptService = EncryptionAlgorithm();

  String encrypt({required String value}) {
    return encryptService.encrypt(value);
  }

  String decrypt({required String encryptedValue}) {
    return encryptService.decrypt(encryptedValue);
  }
}
