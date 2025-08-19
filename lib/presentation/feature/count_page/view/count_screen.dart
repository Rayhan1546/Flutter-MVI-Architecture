import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/presentation/common/listener/listener_state.dart';
import 'package:github_repo_list/presentation/common/widgets/app_loader.dart';
import 'package:github_repo_list/presentation/feature/count_page/components/count_counter.dart';
import 'package:github_repo_list/presentation/feature/count_page/components/count_counter2.dart';
import 'package:github_repo_list/presentation/feature/count_page/components/count_nav_button.dart';
import 'package:github_repo_list/presentation/feature/count_page/view_model/count_state.dart';
import 'package:github_repo_list/presentation/feature/count_page/view_model/count_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:reeve_state/reeve/reeve_builder.dart';
import 'package:reeve_state/reeve/reeve_injecter.dart';

class CountScreen extends StatefulWidget {
  const CountScreen({super.key});

  @override
  State<CountScreen> createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  late CountViewModel viewModel;

  @override
  void initState() {
    viewModel = DIModule().get<CountViewModel>();
    _onViewReady();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _onViewReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.onViewReady();
    });
  }

  void _handleListenerState(ListenerState? state) {
    if (!mounted) return;

    if (state is EmptyState) {
      return;
    } else if (state is ToastMessageState) {
      _showSnackBar(state);
    } else if (state is NavigationState) {
      context.push(state.routePath);
    }
  }

  void _showSnackBar(ToastMessageState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.message)),
    );
  }

  void navigate() {}

  @override
  Widget build(BuildContext context) {
    return ReeveInjecter<CountViewModel>(
      inject: viewModel,
      child: ReeveBuilder<CountState, CountViewModel>(
        buildWhen: (p, n) {
          return p.listenerState != n.listenerState ||
              p.isLoading != n.isLoading;
        },
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _handleListenerState(state.listenerState);
          });

          return AppLoader(
            isLoading: state.isLoading,
            child: Scaffold(
              appBar: AppBar(title: const Text('Count')),
              body: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountCounter(),
                  CountCounter2(),
                  CountNavButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
