enum Social { email, google, facebook, newUser }

abstract class LoginState {}

class InitState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginSuccessState();
}

class LoginErrorState extends LoginState {
  String status;
  LoginErrorState({required this.status});
}

class RememberState extends LoginState {}

class ContinueState extends LoginState {
  bool isContinue;

  ContinueState({required this.isContinue});
}
