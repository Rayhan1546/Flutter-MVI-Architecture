import 'package:github_repo_list/data/data_sources/local/secure_storage/secure_storage.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/app_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';

class SecureLoginManager extends AppStorageManager<bool> {
  @override
  String get key => "secure_login_manager";

  @override
  StorageInterface get storage => SecureStorage();
}
