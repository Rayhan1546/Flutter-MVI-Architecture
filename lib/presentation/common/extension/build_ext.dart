import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/efficient_builder.dart';

extension BuildExtension<T> on ValueListenable<T> {
  Widget build({
    bool Function(T previous, T current)? buildWhen,
    required Widget Function(BuildContext context, T value) builder,
    Key? key,
  }) {
    return EfficientBuilder<T>(
      key: key,
      valueListenable: this,
      buildWhen: buildWhen,
      builder: (context, value, _) => builder(context, value),
    );
  }
}
