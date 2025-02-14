import 'package:github_repo_list/presentation/base/base_argument.dart';

class GithubRepoArgument extends BaseArgument {
  final String email;
  final String password;

  GithubRepoArgument({
    required this.email,
    required this.password,
  });
}
