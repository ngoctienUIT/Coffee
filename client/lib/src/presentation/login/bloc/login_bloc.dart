import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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

    on<LoginWithFacebookEvent>((event, emit) => loginWithFacebook(emit));

    on<RememberLoginEvent>((event, emit) => emit(RememberState()));

    on<ClickLoginEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));
  }

  Future loginWithEmailPassword(
      LoginWithEmailPasswordEvent event, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.login(
          {"loginIdentity": event.email, "hashedPassword": event.password});
      SharedPreferences.getInstance().then((value) {
        value.setString("userID", response.userResponse.id);
        value.setString("token", response.accessToken);
      });
      print(response.accessToken);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(status: e.toString()));
      print(e);
    }
  }

  Future loginWithGoogle(Emitter emit) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print("token: ${googleAuth.accessToken}");
        SharedPreferences.getInstance().then((value) {
          // value.setString("userID", response.userResponse.id);
          value.setString("token", googleAuth.accessToken!);
        });
        emit(LoginSuccessState());

        // final credential = GoogleAuthProvider.credential(
        //   accessToken: googleAuth.accessToken,
        //   idToken: googleAuth.idToken,
        // );
      } else {
        emit(LoginErrorState(status: ""));
      }
    } catch (e) {
      print(e);
      emit(LoginErrorState(status: e.toString()));
    }
  }

  Future loginWithFacebook(Emitter emit) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        print("token ${accessToken.token}");
        SharedPreferences.getInstance().then((value) {
          // value.setString("userID", response.userResponse.id);
          value.setString("token", accessToken.token);
        });
        emit(LoginSuccessState());
      } else {
        print("status: ${result.status.name}");
        print("message: ${result.message!}");
        emit(LoginErrorState(status: result.status.toString()));
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
