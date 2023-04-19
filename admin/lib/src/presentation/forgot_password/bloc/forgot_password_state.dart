abstract class ForgotPasswordState {}

class InitState extends ForgotPasswordState {}

class LoadingState extends ForgotPasswordState {}

class SuccessState extends ForgotPasswordState {
  String resetCredential;

  SuccessState(this.resetCredential);
}

class ErrorState extends ForgotPasswordState {
  String status;
  ErrorState(this.status);
}

class ContinueState extends ForgotPasswordState {
  bool isContinue = false;

  ContinueState(this.isContinue);
}
