import 'package:equatable/equatable.dart';

abstract class NewPasswordState extends Equatable {}

class InitState extends NewPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangePasswordLoadingState extends NewPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangePasswordSuccessState extends NewPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangePasswordErrorState extends NewPasswordState {
  final String status;

  ChangePasswordErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class HidePasswordState extends NewPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class TextChangeState extends NewPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ContinueState extends NewPasswordState {
  final bool isContinue;

  ContinueState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}
