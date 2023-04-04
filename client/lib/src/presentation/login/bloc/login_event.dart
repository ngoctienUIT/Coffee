abstract class LoginEvent {}

class LoginWithEmailPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailPasswordEvent({required this.email, required this.password});
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
