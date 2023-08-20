import 'package:coffee_admin/src/presentation/forgot_password/bloc/forgot_password_event.dart';
import 'package:coffee_admin/src/presentation/forgot_password/bloc/forgot_password_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/remote/api_service/api_service.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(InitState()) {
    on<ShowButtonEvent>((event, emit) => emit(ContinueState(event.isContinue)));

    on<SendForgotPasswordEvent>((event, emit) => sendApi(event.email, emit));
  }

  Future sendApi(String email, Emitter emit) async {
    try {
      emit(LoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.resetPasswordIssue(email);
      emit(SuccessState(response.data));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ErrorState(error));
      print(error);
    } catch (e) {
      emit(ErrorState(e.toString()));
      print(e);
    }
  }
}
