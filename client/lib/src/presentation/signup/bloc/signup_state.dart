import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignUpState extends Equatable {}

class InitState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpState {
  final String status;

  SignUpErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class SignUpGoogleLoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpGoogleSuccessState extends SignUpState {
  final GoogleSignInAccount account;

  SignUpGoogleSuccessState(this.account);

  @override
  List<Object?> get props => [account];
}

class SignUpGoogleErrorState extends SignUpState {
  final String status;

  SignUpGoogleErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class ContinueState extends SignUpState {
  final bool isContinue;

  ContinueState({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordState extends SignUpState {
  final bool isHide;

  HidePasswordState({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}

class TextChangeState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class ChangeBirthdayState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class ChangeGenderState extends SignUpState {
  @override
  List<Object?> get props => [];
}
