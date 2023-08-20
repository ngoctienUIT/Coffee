import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/preferences_model.dart';
import '../../../data/models/user.dart';
import '../../../data/remote/api_service/api_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitState()) {
    on<LoginWithEmailPasswordEvent>(
        (event, emit) => loginWithEmailPassword(event, emit));

    on<RememberLoginEvent>((event, emit) => emit(RememberState()));

    on<ClickLoginEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));
  }

  Future loginWithEmailPassword(
      LoginWithEmailPasswordEvent event, Emitter emit) async {
    try {
      emit(LoginLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      var bytes = utf8.encode(event.password);
      var digest = sha256.convert(bytes);
      print("Digest as hex string: $digest");
      final response = await apiService.login(
          {"loginIdentity": event.email, "hashedPassword": digest.toString()});
      final user = response.data;
      if (user.userResponse.userRole == "CUSTOMER") {
        emit(LoginErrorState(status: "Không có quyền truy cập ứng dụng"));
      } else {
        SharedPreferences.getInstance().then((value) {
          value.setString("userID", user.userResponse.id);
          value.setString("token", user.accessToken);
        });
        print(user.accessToken);
        emit(LoginSuccessState(PreferencesModel(
          token: user.accessToken,
          user: User.fromUserResponse(user.userResponse),
        )));
      }
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(LoginErrorState(status: error));
      print(error);
    } catch (e) {
      emit(LoginErrorState(status: e.toString()));
      print(e);
    }
  }
}
