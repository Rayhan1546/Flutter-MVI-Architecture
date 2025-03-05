import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/extension/context_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_list_tile.dart';
import 'package:github_repo_list/presentation/feature/app/app_states.dart';
import 'package:github_repo_list/presentation/feature/app/app_view_model.dart';

class DarkThemeTile extends StatefulWidget {
  const DarkThemeTile({super.key});

  @override
  State<DarkThemeTile> createState() => _DarkThemeTileState();
}

class _DarkThemeTileState extends State<DarkThemeTile> {
  @override
  Widget build(BuildContext context) {
    final appViewModel = context.getViewModel<AppViewModel>();

    return appViewModel.systemConfig.buildFor(
      select: (state) => state.theme,
      builder: (BuildContext context, AppStates state) {
        final isDarkThemeEnabled = state.theme.getTheme == ThemeMode.dark;

        return Visibility(
          visible: state.theme.getTheme != ThemeMode.system,
          child: CustomListTile(
            title: 'Dark Theme',
            subtitle: 'Toggles between light and dark',
            trailing: Switch(
              value: isDarkThemeEnabled,
              onChanged: (bool value) {
                if (value) {
                  appViewModel.setDarkMode();
                } else {
                  appViewModel.setLightMode();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
