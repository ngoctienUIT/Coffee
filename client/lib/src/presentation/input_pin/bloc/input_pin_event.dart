import 'package:equatable/equatable.dart';

import '../../../core/request/input_pin_request/input_pin_request.dart';

abstract class InputPinEvent extends Equatable {}

class SendEvent extends InputPinEvent {
  final InputPinRequest request;

  SendEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class ShowButtonEvent extends InputPinEvent {
  final bool isContinue;

  ShowButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}
