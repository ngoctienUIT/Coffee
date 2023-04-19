abstract class InputPinEvent {}

class SendEvent extends InputPinEvent {
  String resetCredential;
  String pin;

  SendEvent(this.resetCredential, this.pin);
}

class ShowButtonEvent extends InputPinEvent {
  bool isContinue = false;

  ShowButtonEvent(this.isContinue);
}
