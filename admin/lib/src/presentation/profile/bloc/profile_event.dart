abstract class ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final bool isEdit;

  EditProfileEvent({required this.isEdit});
}

class SaveProfileEvent extends ProfileEvent {}
