import 'dart:io';
import 'package:github_repo_list/core/encryption/encryption_algorithm.dart';
import 'package:path/path.dart' as path;

void main() async {
  try {
    // Find project root directory
    final projectRoot = await findProjectRoot();
    if (projectRoot == null) {
      print(
          'Error: Could not find project root (no pubspec.yaml found in parent directories)');
      exit(1);
    }

    // Get name input
    stdout.write('Enter name for API/token: ');
    final name = stdin.readLineSync()?.trim().toUpperCase();

    if (name == null || name.isEmpty) {
      print('Name cannot be empty');
      exit(1);
    }

    // Get value input
    stdout.write('Enter API/token value: ');
    final value = stdin.readLineSync()?.trim();

    if (value == null || value.isEmpty) {
      print('Value cannot be empty');
      exit(1);
    }

    stdout.write('Enter the env file name: ');
    final fileName = stdin.readLineSync()?.trim();

    if (fileName == null || fileName.isEmpty) {
      print('File Name cannot be empty');
      exit(1);
    }

    // Encrypt the value
    final encryptedValue = encryptValue(value);

    // Update ..env.dev file
    await updateEnvFile(projectRoot, name, encryptedValue, fileName);

    print('\nSuccessfully added encrypted value to ..env.dev file');
    print('Project root: $projectRoot');
    print('Name: $name');
    print('Encrypted Value: $encryptedValue');
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}

Future<String?> findProjectRoot() async {
  Directory current = Directory.current;

  while (true) {
    // Check if pubspec.yaml exists in current directory
    final pubspecFile = File(path.join(current.path, 'pubspec.yaml'));
    if (await pubspecFile.exists()) {
      return current.path;
    }

    // Move up one directory
    final parent = current.parent;

    // If we're already at the root directory, stop searching
    if (parent.path == current.path) {
      return null;
    }

    current = parent;
  }
}

String encryptValue(String value) {
  return EncryptionAlgorithm.instance.encrypt(value);
}

Future<void> updateEnvFile(
  String projectRoot,
  String name,
  String value,
  String envFIleName,
) async {
  // Create the full path to the ..env.dev file
  final envPath = path.join(projectRoot, 'env', envFIleName);
  final envDirectory = Directory(path.dirname(envPath));
  final envFile = File(envPath);

  // Create directories if they don't exist
  if (!await envDirectory.exists()) {
    await envDirectory.create(recursive: true);
  }

  // Create file if it doesn't exist
  if (!await envFile.exists()) {
    await envFile.create(recursive: true);
  }

  String contents = await envFile.exists() ? await envFile.readAsString() : '';

  // Remove all trailing newlines first
  contents = contents.trimRight();

  // If file is not empty, prepare for new content
  if (contents.isNotEmpty) {
    contents += '\n';
  }

  // Split into lines and filter out empty ones
  List<String> lines =
      contents.split('\n').where((line) => line.trim().isNotEmpty).toList();

  // Find if the variable exists
  final index = lines.indexWhere((line) => line.startsWith('$name='));

  if (index != -1) {
    // Update existing value
    lines[index] = '$name=$value';
  } else {
    // Add new value
    lines.add('$name=$value');
  }

  // Join lines and write to file without adding extra newline
  final outputContent = lines.join('\n');
  await envFile.writeAsString(outputContent);
}
