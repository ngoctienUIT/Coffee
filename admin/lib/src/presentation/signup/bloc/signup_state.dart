import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {}

class InitState extends SignUpState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SignUpSuccessState extends SignUpState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SignUpErrorState extends SignUpState {
  final String status;

  SignUpErrorState({required this.status});

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
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeBirthdayState extends SignUpState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
