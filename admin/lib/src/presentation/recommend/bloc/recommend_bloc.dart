import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_event.dart';
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/recommend_use_case/delete_recommend.dart';
import '../../../domain/use_cases/recommend_use_case/get_recommend.dart';

@injectable
class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  final GetRecommendUseCase _getRecommendUseCase;
  final DeleteRecommendUseCase _deleteRecommendUseCase;

  RecommendBloc(this._getRecommendUseCase, this._deleteRecommendUseCase)
      : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<DeleteEvent>(_deleteRecommend);

    on<UpdateData>((event, emit) => getData(false, emit));
  }

  Future getData(bool check, Emitter emit) async {
    if (check) emit(RecommendLoading());
    final response = await _getRecommendUseCase.call();
    if (response is DataSuccess) {
      emit(RecommendLoaded(response.data!));
    } else {
      emit(RecommendError(response.error ?? ""));
    }
  }

  Future _deleteRecommend(DeleteEvent event, Emitter emit) async {
    emit(RecommendLoading(false));
    final response = await _deleteRecommendUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(DeleteSuccess(event.id));
    } else {
      emit(RecommendError(response.error ?? ""));
    }
  }
}
