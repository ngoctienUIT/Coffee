import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/api_service.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(InitState()) {
    on<FetchData>((event, emit) => fetchData(emit));
  }

  Future fetchData(Emitter emit) async {
    try {
      emit(CouponLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllCoupons();
      final coupons = response.data;
      emit(CouponLoaded(coupons));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(CouponError(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(CouponError(e.toString()));
      print(e);
    }
  }
}
