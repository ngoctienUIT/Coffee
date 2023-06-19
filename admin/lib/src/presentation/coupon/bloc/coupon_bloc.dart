import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  PreferencesModel preferencesModel;

  CouponBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<DeleteEvent>((event, emit) => deleteCoupon(event.id, emit));
  }

  Future getData(bool check, Emitter emit) async {
    try {
      if (check) emit(CouponLoading());
      final response = await preferencesModel.apiService.getAllCoupons();

      emit(CouponLoaded(response.data));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(CouponError(error));
      print(error);
    } catch (e) {
      emit(CouponError(e.toString()));
      print(e);
    }
  }

  Future deleteCoupon(String id, Emitter emit) async {
    try {
      emit(CouponLoading(false));
      await preferencesModel.apiService
          .removeCouponByID(id, 'Bearer ${preferencesModel.token}');
      // final response = await apiService.getAllCoupons();
      emit(DeleteCouponSuccess(id));
    } on DioException catch (e) {
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
