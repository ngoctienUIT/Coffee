import 'dart:io';

import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_event.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String image = "";
  PreferencesModel preferencesModel;

  ProfileBloc(this.preferencesModel) : super(InitState()) {
    on<EditProfileEvent>(
        (event, emit) => emit(EditProfileSate(isEdit: event.isEdit)));

    on<SaveProfileEvent>((event, emit) => saveProfile(event.user, emit));

    on<DeleteAvatarEvent>((event, emit) => deleteAvatar(event.user, emit));

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
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        emit(LinkAccountWithGoogleLoadingState());
        ApiService apiService =
            ApiService(Dio(BaseOptions(contentType: "application/json")));
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        await apiService.linkAccountWithOAuth2Provider(
          "Bearer ${preferencesModel.token}",
          {
            "oauth2ProviderUserId": googleUser.id,
            "oauth2ProviderUserIdentity": googleUser.email,
            "oauth2ProviderAccessToken": googleAuth.accessToken,
            "oauth2ProviderProviderName": "GOOGLE",
          },
        );
        emit(LinkAccountWithGoogleSuccessState());
      } else {
        emit(LinkAccountWithGoogleErrorState("Hủy bỏ liên kết"));
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      GoogleSignIn().signOut();
      emit(LinkAccountWithGoogleErrorState(error));
      print(error);
    } catch (e) {
      GoogleSignIn().signOut();
      emit(LinkAccountWithGoogleErrorState(e.toString()));
      print(e);
    }
  }

  Future unlinkAccountWithGoogleEvent(Emitter emit) async {
    try {
      emit(UnlinkAccountWithGoogleLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));

      await apiService.unlinkAccountWithOAuth2Provider(
          "Bearer ${preferencesModel.token}", preferencesModel.user!.id!);
      GoogleSignIn().signOut();
      emit(UnlinkAccountWithGoogleSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      GoogleSignIn().signOut();
      emit(UnlinkAccountWithGoogleErrorState(error));
      print(error);
    } catch (e) {
      GoogleSignIn().signOut();
      emit(UnlinkAccountWithGoogleErrorState(e.toString()));
      print(e);
    }
  }

  Future saveProfile(User user, Emitter emit) async {
    try {
      emit(SaveProfileLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      if (image.isNotEmpty) {
        user.imageUrl = await uploadImage(preferencesModel.user!.username);
      }
      final response = await apiService.updateExistingUser(
          "Bearer ${preferencesModel.token}",
          preferencesModel.user!.username,
          user.toJson());

      emit(SaveProfileLoaded(User.fromUserResponse(response.data)));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(SaveProfileError(error));
      print(error);
    } catch (e) {
      emit(SaveProfileError(e.toString()));
      print(e);
    }
  }

  Future deleteAvatar(User user, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      user.imageUrl = null;
      final response = await apiService.updateExistingUser(
          "Bearer ${preferencesModel.token}",
          preferencesModel.user!.username,
          user.toJson());

      emit(DeleteAvatarState(User.fromUserResponse(response.data)));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(DeleteAvatarErrorState(error));
      print(error);
    } catch (e) {
      emit(DeleteAvatarErrorState(e.toString()));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("avatar/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
