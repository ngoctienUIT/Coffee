import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';

abstract class CouponState {}

class InitState extends CouponState {}

class CouponLoading extends CouponState {}

class CouponLoaded extends CouponState {
  final List<CouponResponse> listCoupon;

  CouponLoaded(this.listCoupon);
}

class CouponError extends CouponState {
  final String? message;
  CouponError(this.message);
}
