import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/presentation/base/base_argument.dart';
import 'package:github_repo_list/presentation/base/base_provider.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/widgets/confirmation_dialog_box.dart';
import 'package:github_repo_list/presentation/navigation/app_router.dart';

abstract class BaseAdaptiveScreen<ViewModel extends BaseViewModel,
    Argument extends BaseArgument> extends StatefulWidget {
  final Argument? arguments;

  const BaseAdaptiveScreen({super.key, required this.arguments});

  @protected
  Widget buildView(BuildContext context);

  @override
  State<BaseAdaptiveScreen<ViewModel, Argument>> createState() =>
      _BaseAdaptiveScreenState<ViewModel, Argument>();
}

class _BaseAdaptiveScreenState<ViewModel extends BaseViewModel,
        Argument extends BaseArgument>
    extends State<BaseAdaptiveScreen<ViewModel, Argument>> {
  late final Argument? _arguments;
  late final ViewModel _viewModel;
  final diModule = DIModule();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _viewModel.onDispose();
    diModule.disposeViewModel<ViewModel>();
    super.dispose();
  }

  void _initialize() {
    _viewModel = diModule.get<ViewModel>();
    _arguments = widget.arguments;
    _onViewReady();
    _setupListener();
  }

  @protected
  void _onViewReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.onViewReady(argument: _arguments);
    });
  }

  void _setupListener() {
    _viewModel.baseState.addListener(
      () {
        final baseState = _viewModel.baseState.value;
        if (!mounted) {
          return;
        }
        if (baseState is NavigateState) {
          _navigateTo(state: baseState);
        }
        if (baseState is ConfirmationDialogState) {
          _showConfirmationDialog(state: baseState);
        }
      },
    );
  }

  void _navigateTo({required NavigateState state}) async {
    if (state.isReplace) {
      await AppRouter.replaceTo(
        context: context,
        routePath: state.routePath,
        arguments: state.arguments,
      );
    } else if (state.isClearBackStack) {
      await AppRouter.clearStackAndGo(
        context: context,
        routePath: state.routePath,
        arguments: state.arguments,
      );
    } else {
      await AppRouter.navigateTo(
        context: context,
        routePath: state.routePath,
        arguments: state.arguments,
      );
    }
  }

  void _showConfirmationDialog({required ConfirmationDialogState state}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmationDialogBox(
          title: state.title,
          subTitle: state.subTitle,
          rightBtnText: state.rightBtnText,
          leftBtnText: state.leftBtnText,
          onTapRightBtn: state.onTapRightBtn,
          onTapLeftBtn: state.onTapLeftBtn,
          icon: state.icon,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseProvider(
      viewModel: _viewModel,
      builder: (context, viewModel) {
        return widget.buildView(context);
      },
    );
  }
}
