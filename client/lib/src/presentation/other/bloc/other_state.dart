import 'package:coffee/src/domain/entities/user/user_response.dart';

abstract class OtherState {}

class InitState extends OtherState {}

class OtherLoading extends OtherState {}

class OtherLoaded extends OtherState {
  final UserResponse user;
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
