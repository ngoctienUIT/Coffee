import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      print("Digest as hex string: $digest");
      await apiService.issueNewPasswordUser(resetCredential, digest.toString());
      emit(ChangePasswordSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ChangePasswordErrorState(status: error));
      print(error);
    } catch (e) {
      emit(ChangePasswordErrorState(status: e.toString()));
      print(e);
    }
  }
}
