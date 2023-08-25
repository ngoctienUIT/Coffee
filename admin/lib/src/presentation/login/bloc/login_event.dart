import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginWithEmailPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailPasswordEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RememberLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ClickLoginEvent extends LoginEvent {
  final bool isContinue;

  ClickLoginEvent({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordEvent extends LoginEvent {
  final bool isHide;

  HidePasswordEvent({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}
