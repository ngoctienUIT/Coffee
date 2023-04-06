import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/domain/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/function/server_status.dart';
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
      final response = await apiService.signup(user.toJson());
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpErrorState(status: serverStatus(e)!));
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
      emit(SignUpErrorState(status: serverStatus(e)!));
    }
  }
}
