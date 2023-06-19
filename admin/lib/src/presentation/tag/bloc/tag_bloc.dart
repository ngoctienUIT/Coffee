import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
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
      final response = await preferencesModel.apiService.getAllTags();
      emit(TagLoaded(response.data));
    } on DioException catch (e) {
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
      await preferencesModel.apiService
          .removeTagByID('Bearer ${preferencesModel.token}', id);
      // final response = await apiService.getAllTags();
      emit(DeleteSuccess(id));
    } on DioException catch (e) {
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
