import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {}

class InitState extends ForgotPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoadingState extends ForgotPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SuccessState extends ForgotPasswordState {
  final String resetCredential;

  SuccessState(this.resetCredential);

  @override
  List<Object?> get props => [resetCredential];
}

class ErrorState extends ForgotPasswordState {
  final String status;

  ErrorState(this.status);

  @override
  List<Object?> get props => [status];
}

class ContinueState extends ForgotPasswordState {
  final bool isContinue;

  ContinueState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}
