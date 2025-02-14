import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_ui.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/route/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/widgets/repository_card.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/widgets/repository_shimmer_card.dart';

class GithubRepoUi extends StatefulWidget {
  final GithubRepoArgument githubRepoArguments;

  const GithubRepoUi({super.key, required this.githubRepoArguments});

  @override
  State<GithubRepoUi> createState() => _GithubRepoUiState();
}

class _GithubRepoUiState extends BaseAdaptiveUI<GithubRepoUi> {
  final _viewModel = DIModule().get<GithubRepoViewModel>();

  @override
  BaseViewModel viewModel() => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel.onViewReady(argument: widget.githubRepoArguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repo List'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _viewModel.gitRepoState.buildFor(
      select: (state) => state.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: 6,
            itemBuilder: (context, index) {
              return const RepositoryShimmerCard();
            },
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            return _viewModel.onRefresh();
          },
          child: _buildRepoCard(context),
        );
      },
    );
  }

  Widget _buildRepoCard(BuildContext context) {
    return _viewModel.gitRepoState.buildFor(
      select: (state) => state.repoList,
      builder: (context, state) {
        return Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: state.repoList.length,
            itemBuilder: (context, index) {
              final repo = state.repoList[index];
              return RepositoryCard(repository: repo);
            },
          ),
        );
      },
    );
  }
}
