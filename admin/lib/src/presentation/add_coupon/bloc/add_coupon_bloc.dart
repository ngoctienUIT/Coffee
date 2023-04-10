import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../data/models/coupon.dart';
import '../../../domain/api_service.dart';
import 'add_coupon_event.dart';
import 'add_coupon_state.dart';

class AddCouponBloc extends Bloc<AddCouponEvent, AddCouponState> {
  String image = "";

  AddCouponBloc() : super(InitState()) {
    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<ChangeTypeEvent>((event, emit) => emit(ChangeTypeState()));

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
      if (image.isNotEmpty) {
        coupon.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.createNewCoupon('Bearer $token', coupon.toJson());
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
      if (image.isNotEmpty) {
        coupon.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.updateExistingCoupon(
          coupon.id!, 'Bearer $token', coupon.toJson());
      emit(AddCouponSuccessState());
    } catch (e) {
      emit(AddCouponErrorState(serverStatus(e)!));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("coupon/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
