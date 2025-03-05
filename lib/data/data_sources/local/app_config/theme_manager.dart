import 'package:github_repo_list/data/data_sources/local/app_config/config_manager.dart';

class ThemeManager extends ConfigManager<String> {
  @override
  String get key => 'theme_manager';
}
