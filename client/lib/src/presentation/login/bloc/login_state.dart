import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

abstract class LoginState extends Equatable {}

class InitState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginSuccessState extends LoginState {
  final User user;
  final String token;

  LoginSuccessState({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];
}

class LoginErrorState extends LoginState {
  final String status;

  LoginErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class LoginGoogleLoadingState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginGoogleSuccessState extends LoginState {
  final User user;
  final String token;

  LoginGoogleSuccessState({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];
}

class LoginGoogleErrorState extends LoginState {
  final String status;

  LoginGoogleErrorState({required this.status});

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
