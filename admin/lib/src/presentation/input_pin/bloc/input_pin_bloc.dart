import 'package:coffee_admin/src/core/request/password_request/input_pin_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/input_pin/bloc/input_pin_event.dart';
import 'package:coffee_admin/src/presentation/input_pin/bloc/input_pin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/password_use_case/input_pin.dart';

class InputPinBloc extends Bloc<InputPinEvent, InputPinState> {
  final InputPinUseCase _useCase;

  InputPinBloc(this._useCase) : super(InitState()) {
    on<SendEvent>(
        (event, emit) => sendApi(event.resetCredential, event.pin, emit));

    on<ShowButtonEvent>((event, emit) => emit(ContinueState(event.isContinue)));
  }

  Future sendApi(String resetCredential, String pin, Emitter emit) async {
    emit(LoadingState());
    final response = await _useCase.call(
        params: InputPinRequest(resetCredential: resetCredential, pin: pin));
    if (response is DataSuccess) {
      emit(SuccessState(response.data!));
    } else {
      emit(ErrorState(response.error ?? ""));
    }
  }
}
