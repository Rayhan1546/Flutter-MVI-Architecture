import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/widgets/repository_shimmer_card.dart';

class RepoShimmer extends StatelessWidget {
  const RepoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const RepositoryShimmerCard();
      },
    );
  }
}
