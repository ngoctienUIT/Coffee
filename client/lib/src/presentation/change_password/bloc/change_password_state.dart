import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {}

class InitState extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordLoadingState extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSuccessState extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String status;

  ChangePasswordErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class ContinueState extends ChangePasswordState {
  final bool isContinue;

  ContinueState({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordState extends ChangePasswordState {
  final bool isHide;

  HidePasswordState({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}

class TextChangeState extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}
