import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
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
    LoginWithEmailPasswordEvent event,
    Emitter emit,
  ) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.login(
          {"loginIdentity": event.email, "hashedPassword": event.password});
      if (response.userResponse.userRole == "CUSTOMER") {
        Fluttertoast.showToast(msg: "Không có quyền");
        emit(LoginErrorState(status: "Không có quyền"));
      } else {
        SharedPreferences.getInstance().then((value) {
          value.setString("userID", response.userResponse.id);
          value.setString("token", response.accessToken);
        });
        print(response.accessToken);
        emit(LoginSuccessState());
      }
    } catch (e) {
      emit(LoginErrorState(status: e.toString()));
      print(e);
    }
  }
}
