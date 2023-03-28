import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      emit(LoginSuccessState(token: response));
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

        emit(LoginSuccessState(token: googleAuth.accessToken!));

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
        emit(LoginSuccessState(token: accessToken.token));
      } else {
        print(result.status);
        print(result.message);
        emit(LoginErrorState(status: result.status.toString()));
      }
    } catch (e) {
      print(e);
    }
  }
}
