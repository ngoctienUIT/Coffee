import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/coupon.dart';
import '../../../data/models/preferences_model.dart';
import 'add_coupon_event.dart';
import 'add_coupon_state.dart';

class AddCouponBloc extends Bloc<AddCouponEvent, AddCouponState> {
  String image = "";
  PreferencesModel preferencesModel;

  AddCouponBloc(this.preferencesModel) : super(InitState()) {
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
      if (image.isNotEmpty) {
        coupon.imageUrl = await uploadImage(image.split("/").last);
      }
      await preferencesModel.apiService
          .createNewCoupon('Bearer ${preferencesModel.token}', coupon.toJson());
      emit(AddCouponSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddCouponErrorState(error));
      print(error);
    } catch (e) {
      emit(AddCouponErrorState(e.toString()));
      print(e);
    }
  }

  Future updateCoupon(Coupon coupon, Emitter emit) async {
    try {
      emit(AddCouponLoadingState());
      if (image.isNotEmpty) {
        coupon.imageUrl = await uploadImage(image.split("/").last);
      }
      await preferencesModel.apiService.updateExistingCoupon(
          coupon.id!, 'Bearer ${preferencesModel.token}', coupon.toJson());
      emit(AddCouponSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddCouponErrorState(error));
      print(error);
    } catch (e) {
      emit(AddCouponErrorState(e.toString()));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("coupon/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
