import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';
import 'new_password_event.dart';
import 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc() : super(InitState()) {
    on<HidePasswordEvent>((event, emit) => emit(HidePasswordState()));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));

    on<ChangePasswordEvent>(
        (event, emit) => sendApi(event.resetCredential, event.password, emit));

    on<ShowChangeButtonEvent>(
        (event, emit) => emit(ContinueState(event.isContinue)));
  }

  Future sendApi(String resetCredential, String password, Emitter emit) async {
    try {
      emit(ChangePasswordLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.issueNewPasswordUser(resetCredential, password);
      emit(ChangePasswordSuccessState());
    } catch (e) {
      emit(ChangePasswordErrorState(status: serverStatus(e)!));
      print(e);
    }
  }
}
