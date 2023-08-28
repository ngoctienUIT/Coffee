import 'package:coffee/src/data/models/user.dart';
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
  final User user;

  SaveProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class SaveProfileError extends ProfileState {
  final String? message;

  SaveProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChangeAvatarState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteAvatarState extends ProfileState {
  final User user;

  DeleteAvatarState(this.user);

  @override
  List<Object?> get props => [user];
}

class DeleteAvatarErrorState extends ProfileState {
  final String error;

  DeleteAvatarErrorState(this.error);

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeBirthdayState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LinkAccountWithGoogleSuccessState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LinkAccountWithGoogleLoadingState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LinkAccountWithGoogleErrorState extends ProfileState {
  final String? message;

  LinkAccountWithGoogleErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class UnlinkAccountWithGoogleSuccessState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UnlinkAccountWithGoogleLoadingState extends ProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UnlinkAccountWithGoogleErrorState extends ProfileState {
  final String? message;

  UnlinkAccountWithGoogleErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
