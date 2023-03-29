import 'package:coffee/src/presentation/activity/bloc/activity_event.dart';
import 'package:coffee/src/presentation/activity/bloc/activity_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(ActivityLoading());
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final listOder =
          await apiService.getOrderHistoryCustomer("Bearer $token", email);
      emit(ActivityLoaded(listOrder: listOder));
    } catch (e) {
      emit(ActivityError(e.toString()));
      print(e);
    }
  }
}
