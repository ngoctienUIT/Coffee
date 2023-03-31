import '../../../data/models/user.dart';

abstract class ChangePasswordEvent {}

class ClickChangePasswordEvent extends ChangePasswordEvent {
  User user;

  ClickChangePasswordEvent(this.user);
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
