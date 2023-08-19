import '../../../core/request/login_request/login_email_password_request.dart';

abstract class LoginEvent {}

class LoginWithEmailPasswordEvent extends LoginEvent {
  LoginEmailPasswordRequest request;

  LoginWithEmailPasswordEvent(this.request);
}

class LoginWithGoogleEvent extends LoginEvent {}

class RememberLoginEvent extends LoginEvent {}

class ClickLoginEvent extends LoginEvent {
  bool isContinue;

  ClickLoginEvent({required this.isContinue});
}

class HidePasswordEvent extends LoginEvent {
  bool isHide;

  HidePasswordEvent({required this.isHide});
}
