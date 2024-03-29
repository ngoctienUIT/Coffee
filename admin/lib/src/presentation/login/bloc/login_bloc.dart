import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/login/login_email_password.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginEmailPasswordUseCase _useCase;

  LoginBloc(this._useCase) : super(InitState()) {
    on<LoginWithEmailPasswordEvent>(_loginWithEmailPassword);

    on<RememberLoginEvent>((event, emit) => emit(RememberState()));

    on<ClickLoginEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));
  }

  Future _loginWithEmailPassword(
      LoginWithEmailPasswordEvent event, Emitter emit) async {
    emit(LoginLoadingState());
    final response = await _useCase.call(params: event);
    if (response is DataSuccess) {
      emit(LoginSuccessState(response.data!));
    } else {
      emit(LoginErrorState(status: response.error ?? ""));
    }
  }
}
