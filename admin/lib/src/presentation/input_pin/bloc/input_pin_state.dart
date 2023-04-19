abstract class InputPinState {}

class InitState extends InputPinState {}

class LoadingState extends InputPinState {}

class SuccessState extends InputPinState {
  bool check;

  SuccessState(this.check);
}

class ErrorState extends InputPinState {
  String error;

  ErrorState(this.error);
}

class ContinueState extends InputPinState {
  bool isContinue = false;

  ContinueState(this.isContinue);
}
