import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/password_use_case/forgot_password.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase _useCase;

  ForgotPasswordBloc(this._useCase) : super(InitState()) {
    on<ShowButtonEvent>((event, emit) => emit(ContinueState(event.isContinue)));

    on<SendForgotPasswordEvent>(_sendApi);
  }

  Future _sendApi(SendForgotPasswordEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await _useCase.call(params: event.email);
    if (response is DataSuccess) {
      emit(SuccessState(response.data!));
    } else {
      emit(ErrorState(response.error ?? ""));
    }
  }
}
