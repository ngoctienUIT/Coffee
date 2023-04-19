abstract class ForgotPasswordEvent {}

class ShowButtonEvent extends ForgotPasswordEvent {
  bool isContinue = false;

  ShowButtonEvent(this.isContinue);
}

class SendForgotPasswordEvent extends ForgotPasswordEvent {
  String email;

  SendForgotPasswordEvent(this.email);
}
