import 'dart:convert';
import 'dart:typed_data';
import 'package:github_repo_list/core/constants/encryption_key_constants.dart';
import 'package:pointycastle/export.dart';
import 'dart:math' as math;

class EncryptionAlgorithm {
  static const int saltLength = 16;
  static const int keyLength = 32;
  static const int ivLength = 16;
  static const int iterationCount = 100;
  static const int macSize = 128;

  static final EncryptionAlgorithm instance = EncryptionAlgorithm._();

  late final SecureRandom _secureRandom;
  final _key = EncryptionKeyConstant.encryptKeyString;

  // Private constructor
  EncryptionAlgorithm._() {
    _initializeSecureRandom();
  }

  void _initializeSecureRandom() {
    final random = math.Random.secure();
    _secureRandom = SecureRandom('Fortuna')
      ..seed(
        KeyParameter(
          Uint8List.fromList(
            List.generate(32, (i) => random.nextInt(256)),
          ),
        ),
      );
  }

  /// Encrypts plaintext using AES-256 in GCM mode
  String encrypt(String plaintext) {
    // Generate IV for this encryption
    final iv = Uint8List(ivLength);
    for (var i = 0; i < ivLength; i++) {
      iv[i] = _secureRandom.nextUint8();
    }

    // Generate salt
    final salt = Uint8List(saltLength);
    for (var i = 0; i < saltLength; i++) {
      salt[i] = _secureRandom.nextUint8();
    }

    try {
      // Setup cipher
      final cipher = GCMBlockCipher(AESEngine());
      cipher.init(
        true,
        AEADParameters(
          KeyParameter(_deriveKey(_key, salt)),
          macSize,
          iv,
          Uint8List(0),
        ),
      );

      // Encrypt
      final data = Uint8List.fromList(utf8.encode(plaintext));
      final ciphertext = cipher.process(data);

      // Combine salt + iv + ciphertext
      final result = Uint8List(saltLength + ivLength + ciphertext.length);
      result.setRange(0, saltLength, salt);
      result.setRange(saltLength, saltLength + ivLength, iv);
      result.setRange(saltLength + ivLength, result.length, ciphertext);

      return base64.encode(result);
    } catch (e) {
      throw Exception('Encryption failed');
    }
  }

  /// Decrypts ciphertext using AES-256 in GCM mode
  String decrypt(String encryptedData) {
    try {
      final data = base64.decode(encryptedData);

      // Extract components
      final salt = data.sublist(0, saltLength);
      final iv = data.sublist(saltLength, saltLength + ivLength);
      final ciphertext = data.sublist(saltLength + ivLength);

      // Setup cipher
      final cipher = GCMBlockCipher(AESEngine());
      cipher.init(
        false,
        AEADParameters(
          KeyParameter(_deriveKey(_key, salt)),
          macSize,
          iv,
          Uint8List(0),
        ),
      );

      // Decrypt
      final decrypted = cipher.process(ciphertext);
      return utf8.decode(decrypted);
    } catch (e) {
      throw Exception('Decryption failed');
    }
  }

  Uint8List _deriveKey(String password, Uint8List salt) {
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(Pbkdf2Parameters(salt, iterationCount, keyLength));
    return pbkdf2.process(Uint8List.fromList(utf8.encode(password)));
  }
}
