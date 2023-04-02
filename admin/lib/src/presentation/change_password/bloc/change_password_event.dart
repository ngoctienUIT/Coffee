abstract class ChangePasswordEvent {}

class ClickChangePasswordEvent extends ChangePasswordEvent {
  String password;

  ClickChangePasswordEvent(this.password);
}

class ShowChangeButtonEvent extends ChangePasswordEvent {
  bool isContinue;

  ShowChangeButtonEvent({required this.isContinue});
}

class HidePasswordEvent extends ChangePasswordEvent {
  bool isHide;

  HidePasswordEvent({required this.isHide});
}

class TextChangeEvent extends ChangePasswordEvent {}
