import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(ChangePasswordErrorState(status: error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(ChangePasswordErrorState(status: e.toString()));
      print(e);
    }
  }
}
