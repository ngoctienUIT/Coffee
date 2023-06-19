import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_event.dart';
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  PreferencesModel preferencesModel;

  RecommendBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<DeleteEvent>((event, emit) => deleteRecommend(event.id, emit));

    on<UpdateData>((event, emit) => getData(false, emit));
  }

  Future getData(bool check, Emitter emit) async {
    try {
      if (check) emit(RecommendLoading());
      final response = await preferencesModel.apiService
          .getListRecommendation('Bearer ${preferencesModel.token}');
      emit(RecommendLoaded(response.data));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(RecommendError(error));
    } catch (e) {
      emit(RecommendError(e.toString()));
      print(e);
    }
  }

  Future deleteRecommend(String id, Emitter emit) async {
    try {
      emit(RecommendLoading(false));
      await preferencesModel.apiService
          .deleteRecommendation("Bearer ${preferencesModel.token}", id);
      // final response = await apiService
      //     .getListRecommendation('Bearer ${preferencesModel.token}');
      emit(DeleteSuccess(id));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(RecommendError(error));
      print(error);
    } catch (e) {
      emit(RecommendError(e.toString()));
      print(e);
    }
  }
}
