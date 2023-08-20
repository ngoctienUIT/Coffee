import 'package:coffee/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/input_pin_use_case/input_pin.dart';
import 'input_pin_event.dart';
import 'input_pin_state.dart';

@injectable
class InputPinBloc extends Bloc<InputPinEvent, InputPinState> {
  final InputPinUseCase _useCase;

  InputPinBloc(this._useCase) : super(InitState()) {
    on<SendEvent>(_sendApi);

    on<ShowButtonEvent>((event, emit) => emit(ContinueState(event.isContinue)));
  }

  Future _sendApi(SendEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await _useCase.call(params: event.request);
    if (response is DataSuccess) {
      emit(SuccessState(response.data!));
    } else {
      emit(ErrorState(response.error ?? ""));
    }
  }
}
