import 'dart:io';

import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_event.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String image = "";

  ProfileBloc() : super(InitState()) {
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
        final prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token") ?? "";
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        await apiService.linkAccountWithOAuth2Provider("Bearer $token", {
          "oauth2ProviderUserId": googleUser.id,
          "oauth2ProviderUserIdentity": googleUser.email,
          "oauth2ProviderAccessToken": googleAuth.accessToken,
          "oauth2ProviderProviderName": "GOOGLE"
        });
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
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String userID = prefs.getString("userID") ?? "";

      await apiService.unlinkAccountWithOAuth2Provider("Bearer $token", userID);
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
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      if (image.isNotEmpty) {
        user.imageUrl = await uploadImage(email);
      }
      await apiService.updateExistingUser(
          "Bearer $token", email, user.toJson());

      emit(SaveProfileLoaded());
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
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      user.imageUrl = null;
      await apiService.updateExistingUser(
          "Bearer $token", email, user.toJson());

      emit(DeleteAvatarState());
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
