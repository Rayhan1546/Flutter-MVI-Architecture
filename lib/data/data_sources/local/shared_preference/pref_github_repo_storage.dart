import 'package:github_repo_list/data/data_sources/local/secure_storage/secure_storage.dart';
import 'package:github_repo_list/data/data_sources/local/shared_preference/shared_pref_storage.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/list_mappable_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';
import 'package:github_repo_list/domain/entities/repository.dart';

class PrefGithubRepoStorageManager
    extends ListMappableStorageManager<Repository> {
  @override
  String get key => "pref_github_repo_storage_manager";

  @override
  StorageInterface get storage => SharedPrefStorage();

  @override
  Repository fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'] as int,
      name: json['name'] as String,
      imgUrl: json['img_url'] as String,
      description: json['description'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson(Repository value) {
    return {
      'id': value.id,
      'name': value.name,
      'img_url': value.imgUrl,
      'description': value.description,
    };
  }

  Future<List<Repository>> getAllRepos() async {
    return await getListFromStorage() ?? [];
  }

  Future<void> insertRepoList(List<Repository> repoList) async {
    await saveListToStorage(repoList);
  }
}
