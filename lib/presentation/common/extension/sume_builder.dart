import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/extension/context_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/efficient_builder.dart';

class SumeBuilder<ViewModel extends BaseViewModel<S>, S extends BaseState> extends StatefulWidget {
  const SumeBuilder({
    super.key,
    required this.builder,
    this.buildWhen,
  });

  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S previous, S current)? buildWhen;

  @override
  State<SumeBuilder<ViewModel, S>> createState() => _SumeBuilderState<ViewModel, S>();
}

class _SumeBuilderState<ViewModel extends BaseViewModel<S>, S extends BaseState> extends State<SumeBuilder<ViewModel, S>> {
  late ViewModel viewModel;

  // @override
  // void initState() {
  //   viewModel = context.getViewModel<ViewModel>();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = context.getViewModel<ViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return EfficientBuilder(
      valueListenable: viewModel.stateListener,
      builder: (context, state, child) => widget.builder(context, state),
      buildWhen: widget.buildWhen,
    );
  }
}
