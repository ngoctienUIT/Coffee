import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitState()) {
    on<LoginWithEmailPasswordEvent>(
        (event, emit) => loginWithEmailPassword(emit));

    on<LoginWithGoogleEvent>((event, emit) => loginWithGoogle(emit));

    on<LoginWithFacebookEvent>((event, emit) => loginWithFacebook(emit));

    on<RememberLoginEvent>((event, emit) => emit(RememberState()));

    on<ClickLoginEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));
  }

  Future loginWithEmailPassword(Emitter emit) async {}

  Future loginWithGoogle(Emitter emit) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print("token: ${googleAuth.accessToken}");

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
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      print("token ${result.accessToken}");
      emit(LoginSuccessState());
    } else {
      print(result.status);
      print(result.message);
      emit(LoginErrorState(status: result.status.toString()));
    }
  }
}
