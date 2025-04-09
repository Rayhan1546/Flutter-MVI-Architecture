import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/feature/count_page/view_model/count_state.dart';
import 'package:reeve_state/reeve/reeve_builder.dart';
import 'package:reeve_state/reeve/reeve_context_extension.dart';
import '../view_model/count_view_model.dart';

class CountCounter2 extends StatelessWidget {
  const CountCounter2({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getReeve<CountViewModel>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReeveBuilder<CountState, CountViewModel>(
            buildWhen: (p, n) => p.counter2 != n.counter2,
            builder: (context, state) {
              print('Counter 2');
              return Text(
                'Count: ${state.counter2}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => viewModel.showToast(),
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
            onPressed: () => viewModel.reset2Counter(),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
