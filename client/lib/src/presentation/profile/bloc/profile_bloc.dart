import 'package:coffee/src/core/request/profile_request/save_profile_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_event.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/profile_use_case/delete_avatar.dart';
import '../../../domain/use_cases/profile_use_case/link_account_with_google.dart';
import '../../../domain/use_cases/profile_use_case/save_profile.dart';
import '../../../domain/use_cases/profile_use_case/unlink_account_with_google.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String image = "";
  final DeleteAvatarUseCase _deleteAvatarUseCase;
  final LinkAccountWithGoogleUseCase _linkAccountWithGoogleUseCase;
  final SaveProfileUseCase _saveProfileUseCase;
  final UnlinkAccountWithGoogleUseCase _unlinkAccountWithGoogleUseCase;

  ProfileBloc(
    this._saveProfileUseCase,
    this._unlinkAccountWithGoogleUseCase,
    this._linkAccountWithGoogleUseCase,
    this._deleteAvatarUseCase,
  ) : super(InitState()) {
    on<EditProfileEvent>(
        (event, emit) => emit(EditProfileSate(isEdit: event.isEdit)));

    on<SaveProfileEvent>(_saveProfile);

    on<DeleteAvatarEvent>(_deleteAvatar);

    on<LinkAccountWithGoogleEvent>(
        (event, emit) => linkAccountWithGoogleEvent(emit));

    on<UnlinkAccountWithGoogleEvent>(
        (event, emit) => unlinkAccountWithGoogleEvent(emit));

    on<PickAvatarEvent>((event, emit) {
      image = event.image;
      emit(ChangeAvatarState());
    });

    on<ChangeBirthdayEvent>((event, emit) => emit(ChangeBirthdayState()));
  }

  Future linkAccountWithGoogleEvent(Emitter emit) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      emit(LinkAccountWithGoogleLoadingState());
      final response =
          await _linkAccountWithGoogleUseCase.call(params: googleUser);
      if (response is DataSuccess) {
        emit(LinkAccountWithGoogleSuccessState());
      } else {
        emit(LinkAccountWithGoogleErrorState(response.error));
      }
    } else {
      emit(LinkAccountWithGoogleErrorState("Hủy bỏ liên kết"));
    }
  }

  Future unlinkAccountWithGoogleEvent(Emitter emit) async {
    emit(UnlinkAccountWithGoogleLoadingState());
    final response = await _unlinkAccountWithGoogleUseCase.call();
    if (response is DataSuccess) {
      emit(UnlinkAccountWithGoogleSuccessState());
    } else {
      emit(UnlinkAccountWithGoogleErrorState(response.error));
    }
  }

  Future _saveProfile(SaveProfileEvent event, Emitter emit) async {
    emit(SaveProfileLoading());
    final response = await _saveProfileUseCase.call(
        params: SaveProfileRequest(image: image, user: event.user));
    if (response is DataSuccess) {
      emit(SaveProfileLoaded(response.data!));
    } else {
      emit(SaveProfileError(response.error));
    }
  }

  Future _deleteAvatar(DeleteAvatarEvent event, Emitter emit) async {
    final response = await _deleteAvatarUseCase.call(params: event.user);
    if (response is DataSuccess) {
      emit(DeleteAvatarState(response.data!));
    } else {
      emit(DeleteAvatarErrorState(response.error ?? ""));
    }
  }
}
