import 'package:coffee/src/core/request/login_request/login_google_request.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart';
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginEmailPasswordUseCase _loginEmailPasswordUseCase;
  final LoginGoogleUseCase _loginGoogleUseCase;

  LoginBloc(this._loginEmailPasswordUseCase, this._loginGoogleUseCase)
      : super(InitState()) {
    on<LoginWithEmailPasswordEvent>(_loginWithEmailPassword);

    on<LoginWithGoogleEvent>(_loginWithGoogle);

    on<RememberLoginEvent>((event, emit) => emit(RememberState()));

    on<ClickLoginEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));
  }

  Future _loginWithEmailPassword(
    LoginWithEmailPasswordEvent event,
    Emitter emit,
  ) async {
    emit(LoginLoadingState());
    final response =
        await _loginEmailPasswordUseCase.call(params: event.request);
    if (response is DataSuccess && response.data != null) {
      emit(LoginSuccessState(
        token: response.data!.accessToken,
        user: User.fromUserResponse(response.data!.userResponse),
      ));
    } else {
      emit(LoginErrorState(status: response.error ?? ""));
    }
  }

  Future _loginWithGoogle(LoginWithGoogleEvent event, Emitter emit) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      emit(LoginGoogleLoadingState());

      final response = await _loginGoogleUseCase.call(
          params: LoginGoogleRequest(googleUser));
      if (response is DataSuccess && response.data != null) {
        emit(LoginGoogleSuccessState(
          token: response.data!.accessToken,
          user: User.fromUserResponse(response.data!.userResponse),
        ));
      } else {
        emit(LoginGoogleErrorState(status: response.error ?? ""));
        GoogleSignIn().signOut();
      }
    } else {
      emit(LoginGoogleErrorState(status: ""));
      GoogleSignIn().signOut();
    }
  }
}
