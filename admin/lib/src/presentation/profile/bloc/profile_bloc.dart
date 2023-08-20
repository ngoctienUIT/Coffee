import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/user.dart';
import '../../../data/remote/api_service/api_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String image = "";

  ProfileBloc() : super(InitState()) {
    on<EditProfileEvent>(
        (event, emit) => emit(EditProfileSate(isEdit: event.isEdit)));

    on<SaveProfileEvent>((event, emit) => saveProfile(event.user, emit));

    on<DeleteAvatarEvent>((event, emit) => deleteAvatar(event.user, emit));

    on<ChangeBirthDayEvent>((event, emit) => emit(ChangeBirthDayState()));

    on<PickAvatarEvent>((event, emit) {
      image = event.image;
      emit(ChangeAvatarState());
    });
  }

  Future saveProfile(User user, Emitter emit) async {
    try {
      emit(SaveProfileLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      if (image.isNotEmpty) {
        user.imageUrl = await uploadImage(user.email);
      }
      await apiService.updateExistingUser(
          "Bearer $token", user.email, user.toJson());
      emit(SaveProfileLoaded());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProfileError(error));
      print(error);
    } catch (e) {
      emit(ProfileError(e.toString()));
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
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProfileError(error));
      print(error);
    } catch (e) {
      emit(ProfileError(e.toString()));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("avatar/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
