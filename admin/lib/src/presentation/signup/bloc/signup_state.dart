abstract class SignUpState {}

class InitState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  String status;
  SignUpErrorState({required this.status});
}

class ContinueState extends SignUpState {
  bool isContinue;

  ContinueState({required this.isContinue});
}

class HidePasswordState extends SignUpState {
  bool isHide;

  HidePasswordState({required this.isHide});
}

class TextChangeState extends SignUpState {}
