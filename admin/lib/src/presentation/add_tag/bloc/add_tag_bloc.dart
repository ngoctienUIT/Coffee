import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../data/models/tag.dart';
import 'add_tag_event.dart';
import 'add_tag_state.dart';

class AddTagBloc extends Bloc<AddTagEvent, AddTagState> {
  PreferencesModel preferencesModel;

  AddTagBloc(this.preferencesModel) : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateTagEvent>((event, emit) => createTag(event.tag, emit));

    on<UpdateTagEvent>((event, emit) => updateTag(event.tag, emit));

    on<ChangeColorEvent>((event, emit) => emit(ChangeColorState()));
  }

  Future createTag(Tag tag, Emitter emit) async {
    try {
      emit(AddTagLoadingState());
      await preferencesModel.apiService
          .createNewTag('Bearer ${preferencesModel.token}', tag.toJson());
      emit(AddTagSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddTagErrorState(error));
      print(error);
    } catch (e) {
      emit(AddTagErrorState(e.toString()));
      print(e);
    }
  }

  Future updateTag(Tag tag, Emitter emit) async {
    try {
      emit(AddTagLoadingState());
      await preferencesModel.apiService.updateExistingTag(
          'Bearer ${preferencesModel.token}', tag.toJson(), tag.tagId!);
      emit(AddTagSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddTagErrorState(error));
      print(error);
    } catch (e) {
      emit(AddTagErrorState(e.toString()));
      print(e);
    }
  }
}
