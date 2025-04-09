import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_list_tile.dart';
import 'package:github_repo_list/presentation/feature/app/app_states.dart';
import 'package:github_repo_list/presentation/feature/app/app_view_model.dart';
import 'package:reeve_state/reeve/reeve_context_extension.dart';

class SystemThemeTile extends StatefulWidget {
  const SystemThemeTile({super.key});

  @override
  State<SystemThemeTile> createState() => _SystemThemeTileState();
}

class _SystemThemeTileState extends State<SystemThemeTile> {
  @override
  Widget build(BuildContext context) {
    final appViewModel = context.getReeve<AppViewModel>();

    return appViewModel.systemConfig.buildFor(
      select: (state) => state.theme,
      builder: (BuildContext context, AppStates state) {
        final isSystemThemeEnabled = state.theme.getTheme == ThemeMode.system;

        return CustomListTile(
          title: 'System Theme',
          subtitle: 'Adapt system theme',
          trailing: Switch(
            value: isSystemThemeEnabled,
            onChanged: (bool value) {
              if (value) {
                appViewModel.setSystemTheme();
              } else {
                appViewModel.setLightMode();
              }
            },
          ),
        );
      },
    );
  }
}
