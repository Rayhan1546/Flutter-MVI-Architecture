abstract class RouteParams {}

class GithubRepoParams extends RouteParams {
  final String email;
  final String password;

  GithubRepoParams({
    required this.email,
    required this.password,
  });
}
