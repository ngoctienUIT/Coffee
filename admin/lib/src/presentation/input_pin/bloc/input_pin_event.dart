import 'package:equatable/equatable.dart';

abstract class InputPinEvent extends Equatable {}

class SendEvent extends InputPinEvent {
  final String resetCredential;
  final String pin;

  SendEvent(this.resetCredential, this.pin);

  @override
  List<Object?> get props => [resetCredential, pin];
}

class ShowButtonEvent extends InputPinEvent {
  final bool isContinue;

  ShowButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}
