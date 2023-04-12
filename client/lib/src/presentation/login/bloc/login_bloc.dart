import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitState()) {
    on<LoginWithEmailPasswordEvent>(
        (event, emit) => loginWithEmailPassword(event, emit));

    on<LoginWithGoogleEvent>((event, emit) => loginWithGoogle(emit));

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
      emit(LoginLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.login(
          {"loginIdentity": event.email, "hashedPassword": event.password});
      final user = response.data;
      SharedPreferences.getInstance().then((value) {
        value.setString("userID", user.userResponse.id);
        value.setString("token", user.accessToken);
      });
      print(user.accessToken);
      emit(LoginSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(LoginErrorState(status: error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(LoginErrorState(status: e.toString()));
      print(e);
    }
  }

  Future loginWithGoogle(Emitter emit) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        emit(LoginLoadingState());

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        ApiService apiService =
            ApiService(Dio(BaseOptions(contentType: "application/json")));
        final response = await apiService.loginCredentialTokenOAuth2({
          "oauth2ProviderUserId": googleUser.id,
          "oauth2ProviderUserIdentity": googleUser.email,
          "oauth2ProviderAccessToken": googleAuth.accessToken,
          "oauth2ProviderProviderName": "GOOGLE"
        });
        print("token: ${googleAuth.accessToken}");
        SharedPreferences.getInstance().then((value) {
          value.setString("userID", response.data.userResponse.id);
          value.setString("token", response.data.accessToken);
          value.setBool("isLogin", true);
        });
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState(status: ""));
        GoogleSignIn().signOut();
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      GoogleSignIn().signOut();
      emit(LoginErrorState(status: error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      GoogleSignIn().signOut();
      emit(LoginErrorState(status: e.toString()));
      print(e);
    }
  }
}
