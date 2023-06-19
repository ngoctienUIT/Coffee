import 'package:coffee/src/presentation/setting/bloc/setting_event.dart';
import 'package:coffee/src/presentation/setting/bloc/setting_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

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
      String email = prefs.getString("username") ?? "admin";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PLACED");
      if (response.data.isEmpty) {
        await apiService.removeUserByID("Bearer $token", id);
        prefs.setBool("isLogin", false);
        emit(DeleteSuccessState());
      } else {
        emit(DeleteErrorState(
            "Bạn vẫn còn ${response.data.length} đơn hàng chưa hoàn tất"));
      }
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
