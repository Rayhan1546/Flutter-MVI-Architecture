import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/login_page/login_ui.dart';
import 'package:github_repo_list/presentation/sign_up_page/sign_up_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginUi(),
    );
  }
}
