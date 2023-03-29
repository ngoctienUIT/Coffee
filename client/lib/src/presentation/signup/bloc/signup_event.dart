import '../../../data/models/user.dart';

abstract class SignUpEvent {}

class SignUpWithEmailPasswordEvent extends SignUpEvent {
  final User user;

  SignUpWithEmailPasswordEvent({required this.user});
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
