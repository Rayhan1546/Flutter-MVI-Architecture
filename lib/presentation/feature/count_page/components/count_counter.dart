import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/feature/count_page/view_model/count_state.dart';
import 'package:reeve_state/reeve/reeve_builder.dart';
import 'package:reeve_state/reeve/reeve_context_extension.dart';
import 'package:reeve_state/reeve_state.dart';
import '../view_model/count_view_model.dart';

class CountCounter extends StatelessWidget {
  const CountCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getReeve<CountViewModel>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReeveBuilder<CountState, CountViewModel>(
            buildWhen: (p, n) => p.counter != n.counter,
            builder: (context, state) {
              print('Counter - 1');
              return Text(
                'Count: ${state.counter}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => viewModel.decrementCounter(),
                child: const Text('-'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => viewModel.incrementCounter(),
                child: const Text('+'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => viewModel.resetCounter(),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
