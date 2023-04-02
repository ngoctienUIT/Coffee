import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/domain/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(InitState()) {
    on<SignUpWithEmailPasswordEvent>(
        (event, emit) => signUpWithEmailPassword(event.user, emit));

    on<SignUpWithGoogleEvent>((event, emit) => signUpWithGoogle(emit));

    on<SignUpWithFacebookEvent>((event, emit) => signUpWithFacebook(emit));

    on<ClickSignUpEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));
  }

  Future signUpWithEmailPassword(User user, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.signup(user.toJson());
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpErrorState(status: e.toString()));
      print(e);
    }
  }

  Future signUpWithGoogle(Emitter emit) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print("token: ${googleAuth.accessToken}");

        emit(SignUpSuccessState());

        // final credential = GoogleAuthProvider.credential(
        //   accessToken: googleAuth.accessToken,
        //   idToken: googleAuth.idToken,
        // );
      } else {
        emit(SignUpErrorState(status: ""));
      }
    } catch (e) {
      print(e);
      emit(SignUpErrorState(status: e.toString()));
    }
  }

  Future signUpWithFacebook(Emitter emit) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        print("token ${result.accessToken}");
        emit(SignUpSuccessState());
      } else {
        print(result.status);
        print(result.message);
        emit(SignUpErrorState(status: result.status.toString()));
      }
    } catch (e) {
      print(e);
    }
  }
}
