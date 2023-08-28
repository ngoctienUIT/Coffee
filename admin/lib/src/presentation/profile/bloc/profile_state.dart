import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {}

class InitState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class EditProfileSate extends ProfileState {
  final bool isEdit;

  EditProfileSate({required this.isEdit});

  @override
  List<Object?> get props => [isEdit];
}

class SaveProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveProfileLoaded extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ProfileError extends ProfileState {
  final String? message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChangeAvatarState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteAvatarState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeBirthDayState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
