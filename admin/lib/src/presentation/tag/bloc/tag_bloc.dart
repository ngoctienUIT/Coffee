import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';
import 'tag_event.dart';
import 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  PreferencesModel preferencesModel;

  TagBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<PickEvent>((event, emit) => emit(PickState()));

    on<DeleteEvent>((event, emit) => deleteTag(event.id, emit));
  }

  Future getData(bool check, Emitter emit) async {
    try {
      if (check) emit(TagLoading());
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
      emit(TagLoading(false));
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.removeTagByID('Bearer ${preferencesModel.token}', id);
      // final response = await apiService.getAllTags();
      emit(DeleteSuccess(id));
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
