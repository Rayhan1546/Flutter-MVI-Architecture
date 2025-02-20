import 'dart:convert';
import 'dart:typed_data';
import 'package:github_repo_list/core/constants/encryption_key_constants.dart';
import 'package:pointycastle/export.dart';
import 'dart:math' as math;

class EncryptionAlgorithm {
  static const int saltLength = 32;
  static const int keyLength = 32;
  static const int ivLength = 16;
  static const int iterationCount = 10000;

  final secureKey = EncryptionKeyConstant.encryptKeyString;

  // Singleton pattern
  EncryptionAlgorithm._internal() {
    _initializeSecureRandom();
  }

  static final EncryptionAlgorithm _instance = EncryptionAlgorithm._internal();
  factory EncryptionAlgorithm() => _instance;

  late final SecureRandom _secureRandom;

  void _initializeSecureRandom() {
    final random = math.Random.secure();
    final seed = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      seed[i] = random.nextInt(256);
    }

    _secureRandom = SecureRandom('Fortuna')..seed(KeyParameter(seed));
  }

  /// Encrypts plaintext using AES-256 in CBC mode with PKCS7 padding
  String encrypt(String plaintext) {
    try {
      // Generate salt and IV
      final salt = _generateSecureRandom(saltLength);
      final iv = _generateSecureRandom(ivLength);

      // Derive key using PBKDF2
      final key = _deriveKey(secureKey, salt);

      // Setup AES cipher in CBC mode with PKCS7 padding
      final cipher = PaddedBlockCipher("AES/CBC/PKCS7");
      final params = PaddedBlockCipherParameters(
          ParametersWithIV(KeyParameter(key), iv), null);
      cipher.init(true, params);

      // Encrypt
      final plaintextBytes = utf8.encode(plaintext);
      final ciphertext = cipher.process(Uint8List.fromList(plaintextBytes));

      // Calculate MAC (HMAC-SHA256)
      final concat = Uint8List(salt.length + iv.length + ciphertext.length);
      concat.setAll(0, salt);
      concat.setAll(salt.length, iv);
      concat.setAll(salt.length + iv.length, ciphertext);

      final mac = _calculateMac(key, concat);

      // Combine everything: salt + iv + ciphertext + mac
      final result = Uint8List(saltLength + ivLength + ciphertext.length + 32);
      result.setAll(0, salt);
      result.setAll(saltLength, iv);
      result.setAll(saltLength + ivLength, ciphertext);
      result.setAll(saltLength + ivLength + ciphertext.length, mac);

      return base64.encode(result);
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }

  /// Decrypts ciphertext using AES-256 in CBC mode with PKCS7 padding
  String decrypt(String encryptedData) {
    try {
      // Decode base64
      final data = base64.decode(encryptedData);

      // Extract components
      if (data.length < saltLength + ivLength + 32) {
        throw Exception('Invalid encrypted data length');
      }

      final salt = data.sublist(0, saltLength);
      final iv = data.sublist(saltLength, saltLength + ivLength);
      final ciphertext = data.sublist(saltLength + ivLength, data.length - 32);
      final mac = data.sublist(data.length - 32);

      // Derive key
      final key = _deriveKey(secureKey, salt);

      // Verify MAC
      final concat = Uint8List(salt.length + iv.length + ciphertext.length);
      concat.setAll(0, salt);
      concat.setAll(salt.length, iv);
      concat.setAll(salt.length + iv.length, ciphertext);

      final calculatedMac = _calculateMac(key, concat);
      if (!_secureEquals(calculatedMac, mac)) {
        throw Exception('MAC verification failed');
      }

      // Setup cipher for decryption
      final cipher = PaddedBlockCipher("AES/CBC/PKCS7");
      final params = PaddedBlockCipherParameters(
          ParametersWithIV(KeyParameter(key), iv), null);
      cipher.init(false, params);

      // Decrypt
      final decrypted = cipher.process(Uint8List.fromList(ciphertext));
      return utf8.decode(decrypted);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  /// Generates cryptographically secure random bytes
  Uint8List _generateSecureRandom(int length) {
    final result = Uint8List(length);
    for (var i = 0; i < length; i++) {
      result[i] = _secureRandom.nextUint8();
    }
    return result;
  }
  
  Uint8List _deriveKey(String password, Uint8List salt) {
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    pbkdf2.init(Pbkdf2Parameters(salt, iterationCount, keyLength));
    return pbkdf2.process(Uint8List.fromList(utf8.encode(password)));
  }

  Uint8List _calculateMac(Uint8List key, Uint8List data) {
    final hmac = HMac(SHA256Digest(), 64);
    hmac.init(KeyParameter(key));
    return hmac.process(data);
  }

  bool _secureEquals(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    int result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }
}
