import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));
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
}
