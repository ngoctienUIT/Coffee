import '../../../data/models/user.dart';

abstract class LoginState {}

class InitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  User user;
  String token;

  LoginSuccessState({required this.user, required this.token});
}

class LoginErrorState extends LoginState {
  String status;

  LoginErrorState({required this.status});
}

class LoginGoogleLoadingState extends LoginState {}

class LoginGoogleSuccessState extends LoginState {
  User user;
  String token;

  LoginGoogleSuccessState({required this.user, required this.token});
}

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
