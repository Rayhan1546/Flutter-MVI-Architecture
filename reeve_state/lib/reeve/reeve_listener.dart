// import 'package:flutter/material.dart';
// import 'package:reeve_state/reeve/listener_state.dart';
// import 'package:reeve_state/reeve/reeve.dart';
// import 'package:reeve_state/reeve/reeve_context_extension.dart';
//
// class ReeveListener<R extends Reeve> extends StatefulWidget {
//   const ReeveListener({
//     super.key,
//     required this.builder,
//     required this.child,
//   });
//
//   final Widget Function(BuildContext context, ListenerState value) builder;
//   final Widget child;
//
//   @override
//   State<ReeveListener<R>> createState() => _ReeveListenerState<R>();
// }
//
// class _ReeveListenerState<R extends Reeve> extends State<ReeveListener<R>> {
//   late R reeve;
//   late ListenerState value;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     reeve = context.getReeve<R>();
//     reeve.listenState.addListener(_onChangedState);
//   }
//
//   @override
//   void dispose() {
//     reeve.listenState.removeListener(_onChangedState);
//     reeve.onDispose();
//     super.dispose();
//   }
//
//   void _onChangedState() {
//     if (!mounted) return;
//
//     final val = reeve.listenState.value;
//     if (val == null) return;
//
//     setState(() {
//       value = val;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, value);
//   }
// }
