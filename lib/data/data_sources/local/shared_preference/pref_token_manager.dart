import 'package:github_repo_list/data/data_sources/local/shared_preference/shared_pref_storage.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/json_mappable_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';
import 'package:github_repo_list/domain/entities/login_credentials.dart';

class PrefTokenManager extends JsonMappableStorageManager<LoginCredentials> {
  @override
  StorageInterface get storage => SharedPrefStorage();

  @override
  String get key => "pref_token";

  @override
  LoginCredentials fromJson(Map<String, dynamic> json) {
    return LoginCredentials(
      token: json['token'],
      refreshToken: json['refreshToken'],
      userName: json['username'],
    );
  }

  @override
  Map<String, dynamic> toJson(LoginCredentials value) {
    return {
      'token': value.token,
      'refreshToken': value.refreshToken,
      'username': value.userName,
    };
  }
}
