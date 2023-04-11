import 'package:google_sign_in/google_sign_in.dart';

abstract class SignUpState {}

class InitState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  String status;
  SignUpErrorState({required this.status});
}

class SignUpGoogleLoadingState extends SignUpState {}

class SignUpGoogleSuccessState extends SignUpState {
  GoogleSignInAccount account;

  SignUpGoogleSuccessState(this.account);
}

class SignUpGoogleErrorState extends SignUpState {
  String status;
  SignUpGoogleErrorState({required this.status});
}

class ContinueState extends SignUpState {
  bool isContinue;

  ContinueState({required this.isContinue});
}

class HidePasswordState extends SignUpState {
  bool isHide;

  HidePasswordState({required this.isHide});
}

class TextChangeState extends SignUpState {}

class ChangeBirthdayState extends SignUpState {}

class ChangeGenderState extends SignUpState {}
