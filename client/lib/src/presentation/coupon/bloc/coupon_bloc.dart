import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(InitState()) {
    on<FetchData>((event, emit) => fetchData(emit));
  }

  Future fetchData(Emitter emit) async {
    // try {
    emit(CouponLoading());
    ApiService apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    final response = await apiService.getAllCoupons();
    final coupons = response.data;
    emit(CouponLoaded(coupons));
    // } catch (e) {
    //   emit(CouponError(serverStatus(e)));
    //   print(serverStatus(e));
    // }
  }
}
