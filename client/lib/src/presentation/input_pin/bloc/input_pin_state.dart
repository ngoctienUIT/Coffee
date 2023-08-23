import 'package:equatable/equatable.dart';

abstract class InputPinState extends Equatable {}

class InitState extends InputPinState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoadingState extends InputPinState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SuccessState extends InputPinState {
  final bool check;

  SuccessState(this.check);

  @override
  List<Object?> get props => [check];
}

class ErrorState extends InputPinState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class ContinueState extends InputPinState {
  final bool isContinue;

  ContinueState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}
