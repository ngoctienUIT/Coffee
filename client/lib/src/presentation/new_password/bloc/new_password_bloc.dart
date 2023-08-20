import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/api_service/api_service.dart';
import '../../../domain/use_cases/new_password_use_case/new_password.dart';
import 'new_password_event.dart';
import 'new_password_state.dart';

@injectable
class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final NewPasswordUseCase _useCase;

  NewPasswordBloc(this._useCase) : super(InitState()) {
    on<HidePasswordEvent>((event, emit) => emit(HidePasswordState()));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));

    on<ChangePasswordEvent>(_sendApi);

    on<ShowChangeButtonEvent>(
        (event, emit) => emit(ContinueState(event.isContinue)));
  }

  Future _sendApi(ChangePasswordEvent event, Emitter emit) async {
    emit(ChangePasswordLoadingState());
    final response = await _useCase.call(params: event.request);
    if (response is DataSuccess) {
      emit(ChangePasswordSuccessState());
    } else {
      emit(ChangePasswordErrorState(status: response.error ?? ""));
    }
  }
}
