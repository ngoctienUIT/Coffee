import 'package:equatable/equatable.dart';

import '../../../core/request/new_password_request/new_password_request.dart';

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
  final NewPasswordRequest request;

  ChangePasswordEvent(this.request);

  @override
  List<Object?> get props => [request];
}
