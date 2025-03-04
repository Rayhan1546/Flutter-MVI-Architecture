abstract class CounterIntent {
  const CounterIntent();
}

class IncrementCounterIntent extends CounterIntent {
  const IncrementCounterIntent();
}

class DecrementCounterIntent extends CounterIntent {
  const DecrementCounterIntent();
}

class ResetCounterIntent extends CounterIntent {
  const ResetCounterIntent();
}
