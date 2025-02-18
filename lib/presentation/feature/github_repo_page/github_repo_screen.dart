import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_ui.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/components/repo_list.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/components/repo_shimmer.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_view_model.dart';

class GithubRepoScreen extends StatefulWidget {
  final GithubRepoArgument githubRepoArguments;

  const GithubRepoScreen({super.key, required this.githubRepoArguments});

  @override
  State<GithubRepoScreen> createState() => _GithubRepoScreenState();
}

class _GithubRepoScreenState extends BaseAdaptiveUI<GithubRepoScreen> {
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
      body: _viewModel.stateListener.buildFor(
        select: (state) => state.isLoading,
        builder: (context, state) {
          if (state.isLoading) {
            return const RepoShimmer();
          }

          return RefreshIndicator(
            onRefresh: () async {
              return _viewModel.onRefresh();
            },
            child: RepoList(viewModel: _viewModel),
          );
        },
      ),
    );
  }
}
