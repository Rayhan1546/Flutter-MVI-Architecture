import 'package:github_repo_list/data/data_sources/local/secure_storage/secure_storage_interface.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/json_mappable_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';
import 'package:github_repo_list/domain/entities/login_credentials.dart';

class SecureTokenManager extends JsonMappableStorageManager<LoginCredentials> {
  @override
  String get key => "secure_token_manager";

  @override
  StorageInterface get storage => SecureStorageInterface();

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
