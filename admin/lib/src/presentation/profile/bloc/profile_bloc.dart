import 'package:coffee_admin/src/core/request/profile_request/save_profile_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/profile_use_case/delete_avatar.dart';
import '../../../domain/use_cases/profile_use_case/save_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String image = "";
  final DeleteAvatarUseCase _deleteAvatarUseCase;
  final SaveProfileUseCase _saveProfileUseCase;

  ProfileBloc(this._saveProfileUseCase, this._deleteAvatarUseCase)
      : super(InitState()) {
    on<EditProfileEvent>(
        (event, emit) => emit(EditProfileSate(isEdit: event.isEdit)));

    on<SaveProfileEvent>(_saveProfile);

    on<DeleteAvatarEvent>(_deleteAvatar);

    on<ChangeBirthDayEvent>((event, emit) => emit(ChangeBirthDayState()));

    on<PickAvatarEvent>((event, emit) {
      image = event.image;
      emit(ChangeAvatarState());
    });
  }

  Future _saveProfile(SaveProfileEvent event, Emitter emit) async {
    emit(SaveProfileLoading());
    final response = await _saveProfileUseCase.call(
        params: SaveProfileRequest(image: image, user: event.user));
    if (response is DataSuccess) {
      emit(SaveProfileLoaded());
    } else {
      emit(ProfileError(response.error));
    }
  }

  Future _deleteAvatar(DeleteAvatarEvent event, Emitter emit) async {
    final response = await _deleteAvatarUseCase.call(params: event.user);
    if (response is DataSuccess) {
      emit(DeleteAvatarState());
    } else {
      emit(ProfileError(response.error));
    }
  }
}
