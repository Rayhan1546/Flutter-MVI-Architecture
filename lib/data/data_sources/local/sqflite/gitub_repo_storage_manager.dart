import 'package:github_repo_list/data/data_sources/local/sqflite/database_storage_manager.dart';
import 'package:github_repo_list/domain/entities/repository.dart';

class GithubRepoStorageManager extends DatabaseStorageManager<Repository> {
  @override
  String get tableName => 'github_repo';

  @override
  Map<String, String> get schema => {
        'id': 'INTEGER PRIMARY KEY',
        'name': 'TEXT NOT NULL',
        'img_url': 'TEXT',
        'description': 'TEXT',
      };

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

  Future<void> insertRepoList(List<Repository> repoList) async {
    for (final repo in repoList) {
      insert(repo);
    }
  }

  Future<List<Repository>> getAllRepos() async {
    return await getAll();
  }
}
