import 'package:github_repo_list/data/data_sources/local/shared_preference/shared_pref_storage.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/app_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';

class PrefLoginManager extends AppStorageManager<bool> {
  @override
  StorageInterface get storage => SharedPrefStorage();

  @override
  String get key => "LoginState";
}
