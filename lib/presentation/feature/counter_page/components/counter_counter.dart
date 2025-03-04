import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/context_ext.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import '../view_model/counter_view_model.dart';
import '../view_model/counter_intent.dart';

class CounterCounter extends StatelessWidget {
  const CounterCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getViewModel<CounterViewModel>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          viewModel.stateListener.buildFor(
            select: (state) => state.counter,
            builder: (context, state) {
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
                onPressed: () {
                  viewModel.dispatchIntent(const DecrementCounterIntent());
                },
                child: const Text('-'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  viewModel.dispatchIntent(const IncrementCounterIntent());
                },
                child: const Text('+'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              viewModel.dispatchIntent(const ResetCounterIntent());
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
