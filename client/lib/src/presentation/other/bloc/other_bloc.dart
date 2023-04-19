import 'package:coffee/src/presentation/other/bloc/other_event.dart';
import 'package:coffee/src/presentation/other/bloc/other_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  OtherBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getUserInfo(emit));

    on<ChangeLanguageEvent>(
        (event, emit) => emit(ChangeLanguageState(language: event.language)));
  }

  Future getUserInfo(Emitter emit) async {
    try {
      emit(OtherLoading());
      var prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("userID") ?? "";
      String token = prefs.getString("token") ?? "";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getUserByID("Bearer $token", id);

      emit(OtherLoaded(response.data));
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
