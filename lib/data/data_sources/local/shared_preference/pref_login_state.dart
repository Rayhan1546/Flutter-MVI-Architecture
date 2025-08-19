import 'package:github_repo_list/data/data_sources/local/shared_preference/app_storage_manager.dart';

class LoginState {
  LoginState({required this.appStorageManager});

  final String key = 'login_state';

  final AppStorageManager appStorageManager;

  Future<void> saveToAppStorage(bool value) async {
    await appStorageManager.saveValue<bool>(key, value);
  }

  Future<bool?> getFromAppStorage() async {
    return appStorageManager.getValue<bool>(key);
  }
}

class State {
  final LoginState loginState = LoginState(
    appStorageManager: SecureStorageManager(),
  );

  Future<void> save() async {
    await loginState.saveToAppStorage(true);
  }
}

class SecureStorageManager extends AppStorageManager {
  @override
  Future<void> clearAll() {
    // TODO: implement clearAll
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<T?> getValue<T>(String key) {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  Future<void> saveValue<T>(String key, T value) {
    // TODO: implement saveValue
    throw UnimplementedError();
  }
}
