import 'package:github_repo_list/presentation/base/base_arguments.dart';

class GithubRepoArgument extends BaseArguments {
  final String email;
  final String password;

  GithubRepoArgument({
    required this.email,
    required this.password,
  });
}
