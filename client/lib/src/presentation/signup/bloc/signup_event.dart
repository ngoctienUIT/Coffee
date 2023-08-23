import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

abstract class SignUpEvent extends Equatable {}

class SignUpWithEmailPasswordEvent extends SignUpEvent {
  final User user;

  SignUpWithEmailPasswordEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignUpWithGoogleEvent extends SignUpEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ClickSignUpEvent extends SignUpEvent {
  final bool isContinue;

  ClickSignUpEvent({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordEvent extends SignUpEvent {
  final bool isHide;

  HidePasswordEvent({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}

class TextChangeEvent extends SignUpEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeBirthdayEvent extends SignUpEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeGenderEvent extends SignUpEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
