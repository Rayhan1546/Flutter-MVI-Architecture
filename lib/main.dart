import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module/injection_container.dart';
import 'package:github_repo_list/presentation/feature/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer().injectDependencies();
  runApp(const MyApp());
}
