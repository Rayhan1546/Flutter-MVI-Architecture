class OwnerResponse {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final String userViewType;
  final bool siteAdmin;

  OwnerResponse({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.userViewType,
    required this.siteAdmin,
  });

  factory OwnerResponse.fromJson(Map<String, dynamic> json) {
    return OwnerResponse(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      nodeId: json['node_id'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      gravatarId: json['gravatar_id'] ?? '',
      url: json['url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      followersUrl: json['followers_url'] ?? '',
      followingUrl: json['following_url'] ?? '',
      gistsUrl: json['gists_url'] ?? '',
      starredUrl: json['starred_url'] ?? '',
      subscriptionsUrl: json['subscriptions_url'] ?? '',
      organizationsUrl: json['organizations_url'] ?? '',
      reposUrl: json['repos_url'] ?? '',
      eventsUrl: json['events_url'] ?? '',
      receivedEventsUrl: json['received_events_url'] ?? '',
      type: json['type'] ?? '',
      userViewType: json['user_view_type'] ?? '',
      siteAdmin: json['site_admin'] ?? false,
    );
  }
}

class RepositoryResponse {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final bool isPrivate;
  final OwnerResponse owner;
  final String htmlUrl;
  final String description;

  RepositoryResponse({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.isPrivate,
    required this.owner,
    required this.htmlUrl,
    required this.description,
  });

  factory RepositoryResponse.fromJson(Map<String, dynamic> json) {
    return RepositoryResponse(
      id: json['id'] ?? 0,
      nodeId: json['node_id'] ?? '',
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      isPrivate: json['private'] ?? false,
      owner: OwnerResponse.fromJson(json['owner'] ?? {}),
      htmlUrl: json['html_url'] ?? '',
      description: json['description'] ?? 'No description available',
    );
  }
}