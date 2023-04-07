import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../data/models/tag.dart';
import '../../../domain/api_service.dart';
import 'add_tag_event.dart';
import 'add_tag_state.dart';

class AddTagBloc extends Bloc<AddTagEvent, AddTagState> {
  AddTagBloc() : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateTagEvent>((event, emit) => createTag(event.tag, emit));

    on<UpdateTagEvent>((event, emit) => updateTag(event.tag, emit));
  }

  Future createTag(Tag tag, Emitter emit) async {
    try {
      emit(AddTagLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.createNewTag('Bearer $token', tag.toJson());
      emit(AddTagSuccessState());
    } catch (e) {
      emit(AddTagErrorState(serverStatus(e)!));
      print(e);
    }
  }

  Future updateTag(Tag tag, Emitter emit) async {
    try {
      emit(AddTagLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.updateExistingTag(
          'Bearer $token', tag.toJson(), tag.tagId!);
      emit(AddTagSuccessState());
    } catch (e) {
      emit(AddTagErrorState(serverStatus(e)!));
      print(e);
    }
  }
}
