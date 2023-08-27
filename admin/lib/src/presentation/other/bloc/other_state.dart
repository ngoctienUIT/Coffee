import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

abstract class OtherState extends Equatable {}

class InitState extends OtherState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OtherLoading extends OtherState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

// class OtherLoaded extends OtherState {
//   final User user;
//
//   OtherLoaded(this.user);
//
//   @override
//   List<Object?> get props => [identityHashCode(this)];
// }

class OtherError extends OtherState {
  final String? message;

  OtherError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChangeLanguageState extends OtherState {
  final int language;

  ChangeLanguageState({required this.language});

  @override
  List<Object?> get props => [language];
}
