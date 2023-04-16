import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      LoginWithEmailPasswordEvent event, Emitter emit) async {
    try {
      emit(LoginLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.login(
          {"loginIdentity": event.email, "hashedPassword": event.password});
      final user = response.data;
      if (user.userResponse.userRole == "CUSTOMER") {
        emit(LoginErrorState(status: "Không có quyền truy cập ứng dụng"));
      } else {
        SharedPreferences.getInstance().then((value) {
          value.setString("userID", user.userResponse.id);
          value.setString("token", user.accessToken);
        });
        print(user.accessToken);
        emit(LoginSuccessState());
      }
    } on DioError catch (e) {
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
