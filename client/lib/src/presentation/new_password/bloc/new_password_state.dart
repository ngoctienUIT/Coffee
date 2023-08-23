import 'package:equatable/equatable.dart';

abstract class NewPasswordState extends Equatable {}

class InitState extends NewPasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordLoadingState extends NewPasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSuccessState extends NewPasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordErrorState extends NewPasswordState {
  final String status;

  ChangePasswordErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class HidePasswordState extends NewPasswordState {
  @override
  List<Object?> get props => [];
}

class TextChangeState extends NewPasswordState {
  @override
  List<Object?> get props => [];
}

class ContinueState extends NewPasswordState {
  final bool isContinue;

  ContinueState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}
