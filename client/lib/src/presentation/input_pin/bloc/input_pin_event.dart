import '../../../core/request/input_pin_request/input_pin_request.dart';

abstract class InputPinEvent {}

class SendEvent extends InputPinEvent {
  final InputPinRequest request;

  SendEvent(this.request);
}

class ShowButtonEvent extends InputPinEvent {
  bool isContinue = false;

  ShowButtonEvent(this.isContinue);
}
