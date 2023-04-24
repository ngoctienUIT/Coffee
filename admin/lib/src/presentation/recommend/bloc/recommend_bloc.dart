import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_event.dart';
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  RecommendBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<DeleteEvent>((event, emit) => deleteRecommend(event.id, emit));

    on<UpdateData>((event, emit) => updateData(emit));
  }

  Future updateData(Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.getListRecommendation('Bearer $token');
      emit(RecommendLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(RecommendError(error));
      print(error);
    } catch (e) {
      emit(RecommendError(e.toString()));
      print(e);
    }
  }

  Future getData(Emitter emit) async {
    try {
      emit(RecommendLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.getListRecommendation('Bearer $token');
      emit(RecommendLoaded(response.data));
    } on DioError catch (e) {
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
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.deleteRecommendation("Bearer $token", id);
      final response = await apiService.getListRecommendation('Bearer $token');
      emit(RecommendLoaded(response.data));
    } on DioError catch (e) {
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
