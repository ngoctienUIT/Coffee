abstract class ProfileState {}

class InitState extends ProfileState {}

class EditProfileSate extends ProfileState {
  final bool isEdit;

  EditProfileSate({required this.isEdit});
}

class SaveProfileLoading extends ProfileState {}

class SaveProfileLoaded extends ProfileState {}

class ProfileError extends ProfileState {
  final String? message;

  ProfileError(this.message);
}

class ChangeAvatarState extends ProfileState {}

class DeleteAvatarState extends ProfileState {}

class ChangeBirthDayState extends ProfileState {}
