import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/domain/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(InitState()) {
    on<SignUpWithEmailPasswordEvent>(
        (event, emit) => signUpWithEmailPassword(event.user, emit));

    on<SignUpWithGoogleEvent>((event, emit) => signUpWithGoogle(emit));

    on<ClickSignUpEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));

    on<ChangeBirthdayEvent>((event, emit) => emit(ChangeBirthdayState()));

    on<ChangeGenderEvent>((event, emit) => emit(ChangeGenderState()));
  }

  Future signUpWithEmailPassword(User user, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.signup(user.toJson());
      emit(SignUpSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(SignUpErrorState(status: error));
      print(error);
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

        emit(SignUpGoogleSuccessState(googleUser));
      } else {
        GoogleSignIn().signOut();
        emit(SignUpGoogleErrorState(status: "Hủy đăng ký Google"));
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(SignUpGoogleErrorState(status: error));
      print(error);
    } catch (e) {
      emit(SignUpGoogleErrorState(status: e.toString()));
      print(e);
    }
  }
}
