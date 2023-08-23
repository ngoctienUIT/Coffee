import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

abstract class ChangePasswordEvent extends Equatable {}

class ClickChangePasswordEvent extends ChangePasswordEvent {
  final User user;

  ClickChangePasswordEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class ShowChangeButtonEvent extends ChangePasswordEvent {
  final bool isContinue;

  ShowChangeButtonEvent({required this.isContinue});

  @override
  List<Object?> get props => [isContinue];
}

class HidePasswordEvent extends ChangePasswordEvent {
  final bool isHide;

  HidePasswordEvent({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}

class TextChangeEvent extends ChangePasswordEvent {
  @override
  List<Object?> get props => [];
}
