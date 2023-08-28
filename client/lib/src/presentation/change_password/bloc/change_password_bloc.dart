import 'package:coffee/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/password_use_case/change_password.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _useCase;

  ChangePasswordBloc(this._useCase) : super(InitState()) {
    on<ClickChangePasswordEvent>(_changePassword);

    on<ShowChangeButtonEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));
  }

  Future _changePassword(ClickChangePasswordEvent event, Emitter emit) async {
    emit(ChangePasswordLoadingState());
    final response = await _useCase.call(params: event.user);
    if (response is DataSuccess) {
      emit(ChangePasswordSuccessState());
    } else {
      emit(ChangePasswordErrorState(status: response.error ?? ""));
    }
  }
}
