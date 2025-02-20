import 'package:github_repo_list/data/data_sources/local/app_config/config_manager.dart';

class LoginStateManager extends ConfigManager<bool> {
  @override
  String get key => 'is_user_logged';
}
