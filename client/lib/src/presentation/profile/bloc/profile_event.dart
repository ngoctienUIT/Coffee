import '../../../data/models/user.dart';

abstract class ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final bool isEdit;

  EditProfileEvent({required this.isEdit});
}

class SaveProfileEvent extends ProfileEvent {
  User user;

  SaveProfileEvent(this.user);
}
