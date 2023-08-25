import 'package:equatable/equatable.dart';

import '../../../data/models/preferences_model.dart';

abstract class LoginState extends Equatable {}

class InitState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginSuccessState extends LoginState {
  final PreferencesModel preferencesModel;

  LoginSuccessState(this.preferencesModel);

  @override
  List<Object?> get props => [preferencesModel];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginErrorState extends LoginState {
  final String status;

  LoginErrorState({required this.status});

  @override
  List<Object?> get props => [status];
}

class RememberState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ContinueState extends LoginState {
  final bool isContinue;

  ContinueState({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordState extends LoginState {
  final bool isHide;

  HidePasswordState({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}
