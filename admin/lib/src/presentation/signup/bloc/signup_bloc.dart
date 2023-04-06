import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/server_status.dart';
import '../../../data/models/user.dart';
import '../../../domain/api_service.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(InitState()) {
    on<SignUpWithEmailPasswordEvent>(
        (event, emit) => signUpWithEmailPassword(event.user, emit));

    on<ClickSignUpEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));

    on<ChangeBirthdayEvent>((event, emit) => emit(ChangeBirthdayState()));
  }

  Future signUpWithEmailPassword(User user, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.signup(user.toJson());
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpErrorState(status: serverStatus(e)!));
      print(e);
    }
  }
}
