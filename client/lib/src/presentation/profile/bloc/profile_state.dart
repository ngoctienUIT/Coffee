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

class ChangeBirthdayState extends ProfileState {}

class LinkAccountWithGoogleSuccessState extends ProfileState {}

class LinkAccountWithGoogleLoadingState extends ProfileState {}

class LinkAccountWithGoogleErrorState extends ProfileState {
  final String? message;
  LinkAccountWithGoogleErrorState(this.message);
}
