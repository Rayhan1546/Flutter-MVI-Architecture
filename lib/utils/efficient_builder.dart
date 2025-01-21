import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EfficientBuilder<T, R> extends StatefulWidget {
  /// The [ValueListenable] whose value you wish to observe.
  final ValueListenable<T> valueListenable;

  /// Called every time the [valueListenable] updates its value.
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  /// Optional function to derive a specific value from T.
  /// If provided, the builder will only be called when this derived value changes.
  final R Function(T value)? buildFor;

  /// Optional predicate to determine if the widget should rebuild.
  final bool Function(T previous, T current)? buildWhen;

  /// Optional child widget that doesn't depend on the value.
  final Widget? child;

  const EfficientBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.buildFor,
    this.buildWhen,
    this.child,
  });

  @override
  State<EfficientBuilder<T, R>> createState() =>
      _EfficientBuilderState<T, R>();
}

class _EfficientBuilderState<T, R> extends State<EfficientBuilder<T, R>> {
  late T _previousValue;
  R? _previousBuildForValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.valueListenable.value;
    _updateBuildForValue();
    widget.valueListenable.addListener(_onValueChanged);
  }

  @override
  void didUpdateWidget(EfficientBuilder<T, R> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_onValueChanged);
      widget.valueListenable.addListener(_onValueChanged);
      _previousValue = widget.valueListenable.value;
      _updateBuildForValue();
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_onValueChanged);
    super.dispose();
  }

  void _updateBuildForValue() {
    if (widget.buildFor != null) {
      _previousBuildForValue = widget.buildFor!(_previousValue);
    }
  }

  bool _shouldRebuild(T previous, T current) {
    if (widget.buildWhen != null) {
      return widget.buildWhen!(previous, current);
    }

    if (widget.buildFor != null) {
      final currentBuildForValue = widget.buildFor!(current);
      return _previousBuildForValue != currentBuildForValue;
    }

    return previous != current;
  }

  void _onValueChanged() {
    final currentValue = widget.valueListenable.value;

    if (_shouldRebuild(_previousValue, currentValue)) {
      setState(() {
        _previousValue = currentValue;
        _updateBuildForValue();
      });
    } else {
      _previousValue = currentValue;
      _updateBuildForValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      widget.valueListenable.value,
      widget.child,
    );
  }
}
