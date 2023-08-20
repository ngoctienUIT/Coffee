import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/activity_use_case/get_activity.dart';

@injectable
class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetActivityUseCase _useCase;

  ActivityBloc(this._useCase) : super(InitState()) {
    on<FetchData>(_getData);

    on<UpdateData>(_updateData);
  }

  Future _getData(FetchData event, Emitter emit) async {
    emit(ActivityLoading(event.index));
    final response = await _useCase.call(params: event.index);
    if (response is DataSuccess) {
      emit(ActivityLoaded(listOrder: response.data!, index: event.index));
    } else {
      emit(ActivityError(message: response.error ?? "", index: event.index));
    }
  }

  Future _updateData(UpdateData event, Emitter emit) async {
    final response = await _useCase.call(params: event.index);
    if (response is DataSuccess) {
      emit(UpdateSuccess(response.data!, event.index));
    } else {
      emit(ActivityError(message: response.error ?? "", index: event.index));
    }
  }
}
