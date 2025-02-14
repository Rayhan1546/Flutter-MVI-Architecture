import 'package:github_repo_list/data/data_sources/local/drift_database/app_database.dart';
import 'package:github_repo_list/data/models/git_response.dart';
import 'package:github_repo_list/domain/entities/repository.dart';

class GitRepositoryMapper {
  static List<Repository> mapToResponse(List<RepositoryResponse> response) {
    return response.map((repo) {
      return Repository(
        id: repo.id,
        name: repo.name,
        description: repo.description,
        imgUrl: repo.owner.avatarUrl,
      );
    }).toList();
  }

  static List<Repository> mapToDatabase(List<GithubTableData> tableData) {
    return tableData.map((repo) {
      return Repository(
        id: repo.id,
        name: repo.name,
        description: repo.description ?? '',
        imgUrl: repo.imgUrl ?? '',
      );
    }).toList();
  }
}
