import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../domain/use_cases/input_info_use_case/input_info.dart';
import 'input_info_event.dart';
import 'input_info_state.dart';

@injectable
class InputInfoBloc extends Bloc<InputInfoEvent, InputInfoState> {
  final InputInfoUseCase _useCase;

  InputInfoBloc(this._useCase) : super(InitState()) {
    on<SubmitEvent>(_submitInfo);

    on<ClickSubmitEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<ChangeBirthdayEvent>((event, emit) => emit(ChangeBirthdayState()));

    on<ChangeGenderEvent>((event, emit) => emit(ChangeGenderState()));
  }

  Future _submitInfo(SubmitEvent request, Emitter emit) async {
    emit(SubmitLoadingState());
    final response = await _useCase.call(params: request.request);
    if (response is DataSuccess) {
      emit(SubmitSuccessState());
    } else {
      emit(SubmitErrorState(status: response.error ?? ""));
    }

    GoogleSignIn().signOut();
  }
}
