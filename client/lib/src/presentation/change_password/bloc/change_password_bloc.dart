import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(InitState()) {
    on<ClickChangePasswordEvent>(
        (event, emit) => changePassword(event.password, emit));

    on<ShowChangeButtonEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));
  }

  Future changePassword(String password, Emitter emit) async {
    try {
      emit(ChangePasswordLoadingState());
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.updateUserField(
          "Bearer $token", email, "hashedPassword", password);
      emit(ChangePasswordSuccessState());
    } catch (e) {
      emit(ChangePasswordErrorState(status: e.toString()));
      print(e);
    }
  }
}
