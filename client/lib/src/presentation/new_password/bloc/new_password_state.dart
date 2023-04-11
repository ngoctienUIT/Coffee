abstract class NewPasswordState {}

class InitState extends NewPasswordState {}

class ChangePasswordLoadingState extends NewPasswordState {}

class ChangePasswordSuccessState extends NewPasswordState {}

class ChangePasswordErrorState extends NewPasswordState {
  String status;
  ChangePasswordErrorState({required this.status});
}

class HidePasswordState extends NewPasswordState {}

class TextChangeState extends NewPasswordState {}

class ContinueState extends NewPasswordState {
  bool isContinue = false;

  ContinueState(this.isContinue);
}
