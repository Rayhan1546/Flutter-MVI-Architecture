import 'package:github_repo_list/data/data_sources/local/shared_preference/shared_pref_storage_interface.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/app_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';

class LoginState extends AppStorageManager {
  @override
  StorageInterface get storage => SharedPrefStorageInterface();

  @override
  String get key => "LoginState";
}
