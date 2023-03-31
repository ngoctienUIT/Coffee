import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_event.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitState()) {
    on<EditProfileEvent>(
        (event, emit) => emit(EditProfileSate(isEdit: event.isEdit)));

    on<SaveProfileEvent>((event, emit) => saveProfile(event.user, emit));
  }

  Future saveProfile(User user, Emitter emit) async {
    try {
      emit(SaveProfileLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      final response = await apiService.updateExistingUser(
          "Bearer $token", email, user.toJson());

      emit(SaveProfileLoaded());
    } catch (e) {
      emit(SaveProfileError(e.toString()));
      print(e);
    }
  }
}
