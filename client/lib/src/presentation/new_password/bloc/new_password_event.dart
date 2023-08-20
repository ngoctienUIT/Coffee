import '../../../core/request/new_password_request/new_password_request.dart';

abstract class NewPasswordEvent {}

class ShowChangeButtonEvent extends NewPasswordEvent {
  bool isContinue = false;

  ShowChangeButtonEvent({required this.isContinue});
}

class HidePasswordEvent extends NewPasswordEvent {}

class TextChangeEvent extends NewPasswordEvent {}

class ChangePasswordEvent extends NewPasswordEvent {
  final NewPasswordRequest request;

  ChangePasswordEvent(this.request);
}
