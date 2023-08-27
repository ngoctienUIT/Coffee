import 'package:coffee_admin/src/data/remote/response/login/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class InitState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginSuccessState extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccessState(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginErrorState extends LoginState {
  final String status;

  LoginErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class RememberState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ContinueState extends LoginState {
  final bool isContinue;

  ContinueState({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordState extends LoginState {
  final bool isHide;

  HidePasswordState({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}
