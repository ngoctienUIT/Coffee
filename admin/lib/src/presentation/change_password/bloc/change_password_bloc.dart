import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../data/models/user.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  PreferencesModel preferencesModel;

  ChangePasswordBloc(this.preferencesModel) : super(InitState()) {
    on<ClickChangePasswordEvent>(
        (event, emit) => changePassword(event.user, emit));

    on<ShowChangeButtonEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));
  }

  Future changePassword(User user, Emitter emit) async {
    try {
      emit(ChangePasswordLoadingState());
      await preferencesModel.apiService.updateExistingUser(
          "Bearer ${preferencesModel.token}",
          preferencesModel.user!.email,
          user.toJson());
      emit(ChangePasswordSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ChangePasswordErrorState(status: error));
      print(error);
    } catch (e) {
      emit(ChangePasswordErrorState(status: e.toString()));
      print(e);
    }
  }
}
