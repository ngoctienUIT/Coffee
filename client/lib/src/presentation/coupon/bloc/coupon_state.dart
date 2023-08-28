import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';
import 'package:equatable/equatable.dart';

abstract class CouponState extends Equatable {}

class InitState extends CouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CouponLoading extends CouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CouponLoaded extends CouponState {
  final List<CouponResponse> listCoupon;

  CouponLoaded(this.listCoupon);

  @override
  List<Object?> get props => [listCoupon];
}

class CouponError extends CouponState {
  final String? message;

  CouponError(this.message);

  @override
  List<Object?> get props => [message];
}
