import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<DeleteEvent>((event, emit) => deleteCoupon(event.id, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(CouponLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllCoupons();

      emit(CouponLoaded(response.data));
    } catch (e) {
      emit(CouponError(serverStatus(e)!));
      print(e);
    }
  }

  Future deleteCoupon(String id, Emitter emit) async {
    try {
      emit(CouponLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.removeCouponByID(id, 'Bearer $token');
      final response = await apiService.getAllCoupons();
      emit(CouponLoaded(response.data));
    } catch (e) {
      emit(CouponError(serverStatus(e)!));
      print(e);
    }
  }
}
