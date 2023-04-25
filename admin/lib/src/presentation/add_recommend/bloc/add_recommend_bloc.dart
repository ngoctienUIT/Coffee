import 'package:coffee_admin/src/data/models/recommend.dart';
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_event.dart';
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class AddRecommendBloc extends Bloc<AddRecommendEvent, AddRecommendState> {
  AddRecommendBloc() : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<ChangeTagEvent>((event, emit) => emit(ChangeTagState()));

    on<ChangeWeatherEvent>((event, emit) => emit(ChangeWeatherState()));

    on<CreateRecommendEvent>(
        (event, emit) => createRecommend(event.recommend, emit));

    on<UpdateRecommendEvent>(
        (event, emit) => updateRecommend(event.recommend, emit));
  }

  Future createRecommend(Recommend recommend, Emitter emit) async {
    try {
      emit(AddRecommendLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.createNewRecommendation(
          'Bearer $token', recommend.toJson());
      emit(AddRecommendSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddRecommendError(error));
      print(error);
    } catch (e) {
      emit(AddRecommendError(e.toString()));
      print(e);
    }
  }

  Future updateRecommend(Recommend recommend, Emitter emit) async {
    try {
      emit(AddRecommendLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.updateExistingRecommendation(
          'Bearer $token', recommend.id!, recommend.toJson());
      emit(AddRecommendSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddRecommendError(error));
      print(error);
    } catch (e) {
      emit(AddRecommendError(e.toString()));
      print(e);
    }
  }
}
