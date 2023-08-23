import 'package:equatable/equatable.dart';

abstract class InputInfoState extends Equatable {}

class InitState extends InputInfoState {
  @override
  List<Object?> get props => [];
}

class SubmitLoadingState extends InputInfoState {
  @override
  List<Object?> get props => [];
}

class SubmitSuccessState extends InputInfoState {
  @override
  List<Object?> get props => [];
}

class SubmitErrorState extends InputInfoState {
  final String status;

  SubmitErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class ContinueState extends InputInfoState {
  final bool isContinue;

  ContinueState({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordState extends InputInfoState {
  final bool isHide;

  HidePasswordState({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}

class TextChangeState extends InputInfoState {
  @override
  List<Object?> get props => [];
}

class ChangeBirthdayState extends InputInfoState {
  @override
  List<Object?> get props => [];
}

class ChangeGenderState extends InputInfoState {
  @override
  List<Object?> get props => [];
}
