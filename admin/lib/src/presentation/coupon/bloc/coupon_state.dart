import '../../../domain/repositories/coupon/coupon_response.dart';

abstract class CouponState {}

class InitState extends CouponState {}

class CouponLoading extends CouponState {
  bool check;

  CouponLoading([this.check = true]);
}

class DeleteCouponSuccess extends CouponState {
  final String id;

  DeleteCouponSuccess(this.id);
}

class CouponLoaded extends CouponState {
  final List<CouponResponse> listCoupon;

  CouponLoaded(this.listCoupon);
}

class CouponError extends CouponState {
  final String? message;
  CouponError(this.message);
}
