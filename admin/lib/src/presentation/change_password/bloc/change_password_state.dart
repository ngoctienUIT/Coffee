abstract class ChangePasswordState {}

class InitState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {}

class ChangePasswordErrorState extends ChangePasswordState {
  String status;
  ChangePasswordErrorState({required this.status});
}

class ContinueState extends ChangePasswordState {
  bool isContinue;

  ContinueState({required this.isContinue});
}

class HidePasswordState extends ChangePasswordState {
  bool isHide;

  HidePasswordState({required this.isHide});
}

class TextChangeState extends ChangePasswordState {}
