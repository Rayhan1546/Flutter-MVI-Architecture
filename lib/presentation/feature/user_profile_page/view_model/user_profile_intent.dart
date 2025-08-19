abstract class UserProfileIntent {
  const UserProfileIntent();
}

class IncrementCounterIntent extends UserProfileIntent {
  const IncrementCounterIntent();
}

class DecrementCounterIntent extends UserProfileIntent {
  const DecrementCounterIntent();
}

class ResetCounterIntent extends UserProfileIntent {
  const ResetCounterIntent();
}
