abstract class ProfileState {}

class InitState extends ProfileState {}

class EditProfileSate extends ProfileState {
  final bool isEdit;

  EditProfileSate({required this.isEdit});
}

class SaveProfileLoading extends ProfileState {}

class SaveProfileLoaded extends ProfileState {}

class SaveProfileError extends ProfileState {
  final String? message;
  SaveProfileError(this.message);
}

class ChangeAvatarState extends ProfileState {}

class DeleteAvatarState extends ProfileState {}

class DeleteAvatarErrorState extends ProfileState {
  String error;

  DeleteAvatarErrorState(this.error);
}

class ChangeBirthdayState extends ProfileState {}

class LinkAccountWithGoogleSuccessState extends ProfileState {}

class LinkAccountWithGoogleLoadingState extends ProfileState {}

class LinkAccountWithGoogleErrorState extends ProfileState {
  final String? message;
  LinkAccountWithGoogleErrorState(this.message);
}

class UnlinkAccountWithGoogleSuccessState extends ProfileState {}

class UnlinkAccountWithGoogleLoadingState extends ProfileState {}

class UnlinkAccountWithGoogleErrorState extends ProfileState {
  final String? message;
  UnlinkAccountWithGoogleErrorState(this.message);
}
