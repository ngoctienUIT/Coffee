import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/presentation/setting/bloc/setting_event.dart';
import 'package:coffee/src/presentation/setting/bloc/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/setting_use_case/delete_account.dart';

@injectable
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final DeleteAccountUseCase _useCase;

  SettingBloc(this._useCase) : super(InitState()) {
    on<DeleteAccountEvent>(_deleteAccount);
  }

  Future _deleteAccount(DeleteAccountEvent event, Emitter emit) async {
    emit(DeleteLoadingState());
    final response = await _useCase.call();
    if (response is DataSuccess) {
      emit(DeleteSuccessState());
    } else {
      emit(DeleteErrorState(response.error ?? ""));
    }
  }
}
