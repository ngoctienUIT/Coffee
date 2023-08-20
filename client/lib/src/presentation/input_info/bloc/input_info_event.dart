import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/request/input_info_request/input_info_request.dart';
import '../../../data/models/user.dart';

abstract class InputInfoEvent {}

class SubmitEvent extends InputInfoEvent {
  InputInfoRequest request;

  SubmitEvent(this.request);
}

class ClickSubmitEvent extends InputInfoEvent {
  bool isContinue;

  ClickSubmitEvent({required this.isContinue});
}

class ChangeBirthdayEvent extends InputInfoEvent {}

class ChangeGenderEvent extends InputInfoEvent {}
