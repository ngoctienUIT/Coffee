import 'package:coffee_admin/src/core/request/coupon_request/coupon_request.dart';

import '../../core/resources/data_state.dart';
import '../../data/remote/response/coupon/coupon_response.dart';

abstract class CouponRepository {
  Future<DataState<List<CouponResponse>>> getAllCoupon();

  Future<DataState<CouponResponse>> createCoupon(CouponRequest request);

  Future<DataState<CouponResponse>> updateCoupon(CouponRequest request);

  Future<DataState<CouponResponse>> deleteCoupon(String id);
}
