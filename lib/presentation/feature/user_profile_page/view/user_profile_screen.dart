import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_screen.dart';
import '../view_model/user_profile_view_model.dart';
import '../components/user_profile_counter.dart';

class UserProfileScreen extends BaseAdaptiveScreen<UserProfileViewModel> {
  const UserProfileScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserProfile'),
      ),
      body: const UserProfileCounter(),
    );
  }
}
