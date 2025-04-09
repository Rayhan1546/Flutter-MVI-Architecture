import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module/injection_container.dart';
import 'package:github_repo_list/presentation/feature/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer().injectDependencies();
  // await dotenv.load(fileName: "env/.env.dev");
  runApp(const MyApp());
}
