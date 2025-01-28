import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension BuilderExtension<T> on ValueListenable<T> {
  Widget efficientBuild<R>({
    final bool Function(T previous, T current)? buildWhen,
    required Widget Function(BuildContext context, T value, Widget? child) builder,
    Widget? child,
    Key? key,
  }) {
    return _EfficientBuilder<T>(
      key: key,
      valueListenable: this,
      buildWhen: buildWhen,
      builder: builder,
      child: child,
    );
  }
}

class _EfficientBuilder<T> extends StatefulWidget {
  final ValueListenable<T> valueListenable;
  final ValueWidgetBuilder<T> builder;
  final bool Function(T previous, T current)? buildWhen;
  final Widget? child;

  const _EfficientBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.buildWhen,
    this.child,
  });

  @override
  State<StatefulWidget> createState() => _EfficientBuilderState<T>();
}

class _EfficientBuilderState<T> extends State<_EfficientBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(_EfficientBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    final newValue = widget.valueListenable.value;

    if (widget.buildWhen == null || widget.buildWhen!(value, newValue)) {
      setState(() {
        value = widget.valueListenable.value;
      });
    } else {
      value = newValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
