import 'dart:convert';
import 'package:github_repo_list/data/models/git_response.dart';
import 'package:http/http.dart' as http;

class GitApiService {
  static const String baseUrl = 'https://api.github.com/repositories';

  Future<List<RepositoryResponse>> fetchRepositories() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map((repoJson) {
        return RepositoryResponse.fromJson(repoJson);
      }).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
