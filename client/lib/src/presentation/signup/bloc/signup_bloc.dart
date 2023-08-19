import 'package:coffee/src/core/request/signup_request/signup_email_password_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/signup_use_case/signup_email_password.dart';
import 'signup_event.dart';
import 'signup_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignupEmailPasswordUseCase _useCase;

  SignUpBloc(this._useCase) : super(InitState()) {
    on<SignUpWithEmailPasswordEvent>(_signUpWithEmailPassword);

    on<SignUpWithGoogleEvent>(_signUpWithGoogle);

    on<ClickSignUpEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));

    on<ChangeBirthdayEvent>((event, emit) => emit(ChangeBirthdayState()));

    on<ChangeGenderEvent>((event, emit) => emit(ChangeGenderState()));
  }

  Future _signUpWithEmailPassword(
      SignUpWithEmailPasswordEvent event, Emitter emit) async {
    var response =
        await _useCase.call(params: SignupEmailPasswordRequest(event.user));
    if (response is DataSuccess) {
      emit(SignUpSuccessState());
    } else {
      emit(SignUpErrorState(status: response.error ?? ""));
    }
  }

  Future _signUpWithGoogle(SignUpWithGoogleEvent event, Emitter emit) async {
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
    } on DioException catch (e) {
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
