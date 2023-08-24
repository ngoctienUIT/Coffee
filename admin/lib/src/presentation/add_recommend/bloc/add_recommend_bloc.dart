import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_event.dart';
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/recommend_use_case/create_recommend.dart';
import '../../../domain/use_cases/recommend_use_case/update_recommend.dart';

@injectable
class AddRecommendBloc extends Bloc<AddRecommendEvent, AddRecommendState> {
  final CreateRecommendUseCase _createRecommendUseCase;
  final UpdateRecommendUseCase _updateRecommendUseCase;

  AddRecommendBloc(this._createRecommendUseCase, this._updateRecommendUseCase)
      : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<ChangeTagEvent>((event, emit) => emit(ChangeTagState()));

    on<ChangeWeatherEvent>((event, emit) => emit(ChangeWeatherState()));

    on<CreateRecommendEvent>(_createRecommend);

    on<UpdateRecommendEvent>(_updateRecommend);
  }

  Future _createRecommend(CreateRecommendEvent event, Emitter emit) async {
    emit(AddRecommendLoading());
    final response =
        await _createRecommendUseCase.call(params: event.recommend);
    if (response is DataSuccess) {
      emit(AddRecommendSuccess());
    } else {
      emit(AddRecommendError(response.error ?? ""));
    }
  }

  Future _updateRecommend(UpdateRecommendEvent event, Emitter emit) async {
    emit(AddRecommendLoading());
    final response =
        await _updateRecommendUseCase.call(params: event.recommend);
    if (response is DataSuccess) {
      emit(AddRecommendSuccess());
    } else {
      emit(AddRecommendError(response.error ?? ""));
    }
  }
}
