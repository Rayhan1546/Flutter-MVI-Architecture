import 'package:drift/drift.dart';
import 'package:github_repo_list/database/drift_database/app_database.dart';
import 'package:github_repo_list/database/drift_database/github_database/github_table.dart';

part 'github_dao.g.dart';

@DriftAccessor(tables: [GithubTable])
class GithubDao extends DatabaseAccessor<AppDatabase> with _$GithubDaoMixin {
  GithubDao(AppDatabase db) : super(db);

  Future<int> insertRepo({
    required int id,
    required String name,
    String? imgUrl,
    String? description,
  }) async {
    return into(githubTable).insert(
      GithubTableCompanion(
        id: Value(id),
        name: Value(name),
        imgUrl: Value(imgUrl),
        description: Value(description),
      ),
    );
  }

  Future<List<GithubTableData>> getAllRepos() {
    return select(githubTable).get();
  }

  Stream<List<GithubTableData>> watchAllRepos() {
    return select(githubTable).watch();
  }

  Future<int> deleteAllRepos() async {
    return delete(githubTable).go();
  }
}
