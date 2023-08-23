import 'package:equatable/equatable.dart';

import '../../../core/request/login_request/login_email_password_request.dart';

abstract class LoginEvent extends Equatable {}

class LoginWithEmailPasswordEvent extends LoginEvent {
  final LoginEmailPasswordRequest request;

  LoginWithEmailPasswordEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class LoginWithGoogleEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class RememberLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
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
