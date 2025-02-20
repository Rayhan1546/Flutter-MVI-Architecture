import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_repo_list/core/services/encryption_service.dart';
import 'package:github_repo_list/di/di_module/injection_container.dart';
import 'package:github_repo_list/presentation/feature/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer().injectDependencies();
  await dotenv.load(fileName: "env/.env.dev");
  print("API_BASE_URL:${dotenv.env['API_BASE_URL']}");
  final decryptValue = EncryptionService().decryptEnvValue(envKey: 'API_BASE_URL');
  print(decryptValue);
  runApp(const MyApp());
}
