import 'package:equatable/equatable.dart';

abstract class NewPasswordEvent extends Equatable {}

class ShowChangeButtonEvent extends NewPasswordEvent {
  final bool isContinue;

  ShowChangeButtonEvent({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordEvent extends NewPasswordEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class TextChangeEvent extends NewPasswordEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangePasswordEvent extends NewPasswordEvent {
  final String resetCredential;
  final String password;

  ChangePasswordEvent(this.resetCredential, this.password);

  @override
  List<Object?> get props => [identityHashCode(this)];
}
