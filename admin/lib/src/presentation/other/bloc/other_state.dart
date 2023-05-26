import '../../../data/models/user.dart';

abstract class OtherState {}

class InitState extends OtherState {}

class OtherLoading extends OtherState {}

class OtherLoaded extends OtherState {
  final User user;

  OtherLoaded(this.user);
}

class OtherError extends OtherState {
  final String? message;
  OtherError(this.message);
}

class ChangeLanguageState extends OtherState {
  final int language;

  ChangeLanguageState({required this.language});
}
