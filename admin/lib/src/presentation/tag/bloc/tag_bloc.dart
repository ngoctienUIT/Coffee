import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import 'tag_event.dart';
import 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<UpdateData>((event, emit) => updateData(emit));

    on<PickEvent>((event, emit) => emit(PickState()));

    on<DeleteEvent>((event, emit) => deleteTag(event.id, emit));
  }

  Future updateData(Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllTags();
      emit(TagLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(TagError(error));
      print(error);
    } catch (e) {
      emit(TagError(e.toString()));
      print(e);
    }
  }

  Future getData(Emitter emit) async {
    try {
      emit(TagLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllTags();
      emit(TagLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(TagError(error));
      print(error);
    } catch (e) {
      emit(TagError(e.toString()));
      print(e);
    }
  }

  Future deleteTag(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.removeTagByID('Bearer $token', id);
      final response = await apiService.getAllTags();
      emit(TagLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(TagError(error));
      print(error);
    } catch (e) {
      emit(TagError(e.toString()));
      print(e);
    }
  }
}
