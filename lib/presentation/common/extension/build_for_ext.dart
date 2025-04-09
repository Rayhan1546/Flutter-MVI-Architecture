import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/efficient_builder.dart';

extension BuildForExtension<T> on ValueListenable<T> {
  Widget buildFor({
    required Function(T state) select,
    required Widget Function(BuildContext context, T state) builder,
    Key? key,
  }) {
    return EfficientBuilder<T>(
      key: key,
      valueListenable: this,
      buildWhen: (previous, current) => select(previous) != select(current),
      builder: (context, state, _) => builder(context, state),
    );
  }
}
