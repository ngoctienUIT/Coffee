import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("userID") ?? "";
      final response = await apiService.getAvailableCoupons(id);
      final coupons = response.data;
      emit(CouponLoaded(coupons
          .where((element) =>
              element.dueDate.toDate().difference(DateTime.now()).inSeconds >=
              0)
          .toList()));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(CouponError(error));
      print(error);
    } catch (e) {
      emit(CouponError(e.toString()));
      print(e);
    }
  }
}
