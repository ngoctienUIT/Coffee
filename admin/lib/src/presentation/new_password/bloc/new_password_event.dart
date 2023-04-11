abstract class NewPasswordEvent {}

class ShowChangeButtonEvent extends NewPasswordEvent {
  bool isContinue = false;

  ShowChangeButtonEvent({required this.isContinue});
}

class HidePasswordEvent extends NewPasswordEvent {}

class TextChangeEvent extends NewPasswordEvent {}

class ChangePasswordEvent extends NewPasswordEvent {
  String resetCredential;
  String password;

  ChangePasswordEvent(this.resetCredential, this.password);
}
