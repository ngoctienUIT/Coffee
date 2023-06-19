import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';
import 'input_pin_event.dart';
import 'input_pin_state.dart';

class InputPinBloc extends Bloc<InputPinEvent, InputPinState> {
  InputPinBloc() : super(InitState()) {
    on<SendEvent>(
        (event, emit) => sendApi(event.resetCredential, event.pin, emit));

    on<ShowButtonEvent>((event, emit) => emit(ContinueState(event.isContinue)));
  }

  Future sendApi(String resetCredential, String pin, Emitter emit) async {
    try {
      emit(LoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response =
          await apiService.validateResetTokenClient(resetCredential, pin);
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
