import 'package:flutter/material.dart';
import 'package:reeve_state/reeve/reeve.dart';
import 'package:reeve_state/reeve/reeve_context_extension.dart';

class ReeveBuilder<T, R extends Reeve<T>> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final bool Function(T previous, T current)? buildWhen;
  final Widget? child;

  const ReeveBuilder({
    super.key,
    required this.builder,
    this.buildWhen,
    this.child,
  });

  @override
  ReeveBuilderState<T, R> createState() => ReeveBuilderState<T, R>();
}

class ReeveBuilderState<T, R extends Reeve<T>>
    extends State<ReeveBuilder<T, R>> {
  late R reeve;
  late T value;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newReeve = context.getReeve<R>();

    if (!mounted) return;

    if (!_isInitialized) {
      reeve = newReeve;
      value = reeve.value;
      reeve.addListener(_valueChanged);
      _isInitialized = true;
    } else if (reeve != newReeve) {
      reeve.removeListener(_valueChanged);
      reeve = newReeve;
      value = reeve.value;
      reeve.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      reeve.removeListener(_valueChanged);
    }
    super.dispose();
  }

  void _valueChanged() {
    final newValue = reeve.value;
    if (widget.buildWhen == null || widget.buildWhen!(value, newValue)) {
      if (mounted) {
        setState(() => value = newValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox.shrink();
    }
    return widget.builder(context, value);
  }
}
