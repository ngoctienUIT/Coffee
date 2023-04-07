import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';
import 'tag_event.dart';
import 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<DeleteEvent>((event, emit) => deleteTag(event.id, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(TagLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllTags();
      emit(TagLoaded(response.data));
    } catch (e) {
      emit(TagError(serverStatus(e)!));
      print(e);
    }
  }

  Future deleteTag(String id, Emitter emit) async {
    try {
      emit(TagLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.removeTagByID('Bearer $token', id);
      final response = await apiService.getAllTags();
      emit(TagLoaded(response.data));
    } catch (e) {
      emit(TagError(serverStatus(e)!));
      print(e);
    }
  }
}
