import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/other/bloc/other_event.dart';
import 'package:coffee/src/presentation/other/bloc/other_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  PreferencesModel preferencesModel;

  OtherBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getUserInfo(emit));

    on<ChangeLanguageEvent>(
        (event, emit) => emit(ChangeLanguageState(language: event.language)));
  }

  Future getUserInfo(Emitter emit) async {
    try {
      if (preferencesModel.user == null) {
        emit(OtherLoading());
      }
      if (preferencesModel.user != null) {
        emit(OtherLoaded(preferencesModel.user!));
      }
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getUserByID(
          "Bearer ${preferencesModel.token}", preferencesModel.user!.id ?? "");
      User user = User.fromUserResponse(response.data);
      if (user != preferencesModel.user) {
        emit(OtherLoaded(user));
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OtherError(error));
      print(error);
    } catch (e) {
      emit(OtherError(e.toString()));
      print(e);
    }
  }
}
