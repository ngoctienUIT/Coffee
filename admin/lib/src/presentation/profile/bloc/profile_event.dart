import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

abstract class ProfileEvent extends Equatable {}

class EditProfileEvent extends ProfileEvent {
  final bool isEdit;

  EditProfileEvent({required this.isEdit});

  @override
  List<Object?> get props => [isEdit];
}

class SaveProfileEvent extends ProfileEvent {
  final User user;

  SaveProfileEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class PickAvatarEvent extends ProfileEvent {
  final String image;

  PickAvatarEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class ChangeBirthDayEvent extends ProfileEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteAvatarEvent extends ProfileEvent {
  final User user;

  DeleteAvatarEvent(this.user);

  @override
  List<Object?> get props => [user];
}
