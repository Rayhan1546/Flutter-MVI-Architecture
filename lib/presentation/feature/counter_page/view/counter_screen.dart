import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_screen.dart';
import '../argument/counter_argument.dart';
import '../view_model/counter_view_model.dart';
import '../components/counter_counter.dart';

class CounterScreen extends BaseAdaptiveScreen<CounterViewModel, CounterArgument> {
  const CounterScreen({super.key, required super.arguments});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: const CounterCounter(),
    );
  }
}
