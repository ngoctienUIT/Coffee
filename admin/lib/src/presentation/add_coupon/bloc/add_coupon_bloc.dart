import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../data/models/coupon.dart';
import '../../../domain/api_service.dart';
import 'add_coupon_event.dart';
import 'add_coupon_state.dart';

class AddCouponBloc extends Bloc<AddCouponEvent, AddCouponState> {
  AddCouponBloc() : super(InitState()) {
    on<ChangeImageEvent>((event, emit) => emit(ChangeImageState()));

    on<ChangeDateEvent>((event, emit) => emit(ChangeDateState()));

    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateCouponEvent>((event, emit) => createCoupon(event.coupon, emit));

    on<UpdateCouponEvent>((event, emit) => updateCoupon(event.coupon, emit));
  }

  Future createCoupon(Coupon coupon, Emitter emit) async {
    try {
      emit(AddCouponLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.createNewCoupon(
        'Bearer $token',
        coupon.toJson(),
      );
      emit(AddCouponSuccessState());
    } catch (e) {
      emit(AddCouponErrorState(serverStatus(e)!));
      print(e);
    }
  }

  Future updateCoupon(Coupon coupon, Emitter emit) async {
    try {
      emit(AddCouponLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.updateExistingCoupon(
        coupon.id!,
        'Bearer $token',
        coupon.toJson(),
      );
      emit(AddCouponSuccessState());
    } catch (e) {
      emit(AddCouponErrorState(serverStatus(e)!));
      print(e);
    }
  }
}
