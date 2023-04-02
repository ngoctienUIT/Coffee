import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(event.index, emit));
  }

  Future getData(int index, Emitter emit) async {
    try {
      emit(ActivityLoading(index));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final listOder = index == 0
          ? await apiService.getAllOrders("Bearer $token", email, "PLACED")
          : await apiService.getAllOrders("Bearer $token", email, "COMPLETED");
      emit(ActivityLoaded(listOrder: listOder, index: index));
    } catch (e) {
      emit(ActivityError(message: e.toString(), index: index));
      print(e);
    }
  }
}
