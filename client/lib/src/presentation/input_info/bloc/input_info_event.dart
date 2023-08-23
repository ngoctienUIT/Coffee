import 'package:equatable/equatable.dart';

import '../../../core/request/input_info_request/input_info_request.dart';

abstract class InputInfoEvent extends Equatable {}

class SubmitEvent extends InputInfoEvent {
  final InputInfoRequest request;

  SubmitEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class ClickSubmitEvent extends InputInfoEvent {
  final bool isContinue;

  ClickSubmitEvent({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class ChangeBirthdayEvent extends InputInfoEvent {
  @override
  List<Object?> get props => [];
}

class ChangeGenderEvent extends InputInfoEvent {
  @override
  List<Object?> get props => [];
}
