import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/models/user.dart';

abstract class InputInfoEvent {}

class SubmitEvent extends InputInfoEvent {
  final User user;
  final GoogleSignInAccount account;

  SubmitEvent({required this.user, required this.account});
}

class ClickSubmitEvent extends InputInfoEvent {
  bool isContinue;

  ClickSubmitEvent({required this.isContinue});
}

class ChangeBirthdayEvent extends InputInfoEvent {}

class ChangeGenderEvent extends InputInfoEvent {}
