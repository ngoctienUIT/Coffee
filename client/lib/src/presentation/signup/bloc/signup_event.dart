abstract class SignUpEvent {}

class SignUpWithEmailPasswordEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpWithEmailPasswordEvent({required this.email, required this.password});
}

class SignUpWithGoogleEvent extends SignUpEvent {}

class SignUpWithFacebookEvent extends SignUpEvent {}

class ClickSignUpEvent extends SignUpEvent {
  bool isContinue;

  ClickSignUpEvent({required this.isContinue});
}

class HidePasswordEvent extends SignUpEvent {
  bool isHide;

  HidePasswordEvent({required this.isHide});
}
