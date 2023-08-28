import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';

import 'package:coffee_admin/src/data/remote/response/coupon/coupon_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/request/coupon_request/coupon_request.dart';
import '../../domain/repositories/coupon_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: CouponRepository)
class CouponRepositoryImpl extends CouponRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  CouponRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<CouponResponse>> createCoupon(CouponRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.coupon.imageUrl = await uploadImage(
          folder: "coupon",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.createNewCoupon(
          'Bearer $token', request.coupon.toJson());
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CouponResponse>> deleteCoupon(String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.removeCouponByID(id, 'Bearer $token');
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<CouponResponse>>> getAllCoupon() async {
    try {
      final response = await _apiService.getAllCoupons();
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CouponResponse>> updateCoupon(CouponRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.coupon.imageUrl = await uploadImage(
          folder: "coupon",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.updateExistingCoupon(
          request.coupon.id!, 'Bearer $token', request.coupon.toJson());
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
