import 'package:coffee/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/forgot_password_use_case/forgot_password.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase _userCase;

  ForgotPasswordBloc(this._userCase) : super(InitState()) {
    on<ShowButtonEvent>((event, emit) => emit(ContinueState(event.isContinue)));

    on<SendForgotPasswordEvent>(_sendEmail);
  }

  Future _sendEmail(SendForgotPasswordEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await _userCase.call(params: event.email);
    if (response is DataSuccess) {
      emit(SuccessState(response.data!));
    } else {
      emit(ErrorState(response.error ?? ""));
    }
  }
}
