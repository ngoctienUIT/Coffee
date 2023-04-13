abstract class LoginState {}

class InitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  String status;
  LoginErrorState({required this.status});
}

class LoginGoogleLoadingState extends LoginState {}

class LoginGoogleSuccessState extends LoginState {}

class LoginGoogleErrorState extends LoginState {
  String status;
  LoginGoogleErrorState({required this.status});
}

class RememberState extends LoginState {}

class ContinueState extends LoginState {
  bool isContinue;

  ContinueState({required this.isContinue});
}

class HidePasswordState extends LoginState {
  bool isHide;

  HidePasswordState({required this.isHide});
}
