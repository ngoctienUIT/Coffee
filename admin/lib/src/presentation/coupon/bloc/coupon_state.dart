import 'package:equatable/equatable.dart';

import '../../../data/remote/response/coupon/coupon_response.dart';

abstract class CouponState extends Equatable {}

class InitState extends CouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CouponLoading extends CouponState {
  final bool check;

  CouponLoading([this.check = true]);

  @override
  List<Object?> get props => [check];
}

class DeleteCouponSuccess extends CouponState {
  final String id;

  DeleteCouponSuccess(this.id);

  @override
  List<Object?> get props => [id];
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
