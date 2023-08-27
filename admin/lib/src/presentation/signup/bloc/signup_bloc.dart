import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user.dart';
import '../../../domain/use_cases/signup_use_case/signup_email_password.dart';
import 'signup_event.dart';
import 'signup_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpEmailPasswordUseCase _useCase;

  SignUpBloc(this._useCase) : super(InitState()) {
    on<SignUpWithEmailPasswordEvent>(
        (event, emit) => signUpWithEmailPassword(event.user, emit));

    on<ClickSignUpEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));

    on<ChangeBirthdayEvent>((event, emit) => emit(ChangeBirthdayState()));
  }

  Future signUpWithEmailPassword(User user, Emitter emit) async {
    emit(SignUpLoadingState());
    final response = await _useCase.call(params: user);
    if (response is DataSuccess) {
      emit(SignUpSuccessState());
    } else {
      emit(SignUpErrorState(status: response.error ?? ""));
    }
  }
}
