import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../data/models/user.dart';
import '../../../domain/api_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String image = "";

  ProfileBloc() : super(InitState()) {
    on<EditProfileEvent>(
        (event, emit) => emit(EditProfileSate(isEdit: event.isEdit)));

    on<SaveProfileEvent>((event, emit) => saveProfile(event.user, emit));

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
    } catch (e) {
      emit(SaveProfileError(serverStatus(e)));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("avatar/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
