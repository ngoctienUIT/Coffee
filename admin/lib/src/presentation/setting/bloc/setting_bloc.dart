import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/remote/api_service/api_service.dart';
import 'setting_event.dart';
import 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(InitState()) {
    on<DeleteAccountEvent>((event, emit) => deleteAccount(emit));
  }

  Future deleteAccount(Emitter emit) async {
    try {
      emit(DeleteLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("userID") ?? "";
      String token = prefs.getString("token") ?? "";
      await apiService.removeUserByID("Bearer $token", id);
      prefs.setBool("isLogin", false);
      emit(DeleteSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(DeleteErrorState(error));
      print(error);
    } catch (e) {
      emit(DeleteErrorState(e.toString()));
      print(e);
    }
  }
}
