import 'package:equatable/equatable.dart';

import '../../../data/models/coupon.dart';

abstract class AddCouponEvent extends Equatable {}

class CreateCouponEvent extends AddCouponEvent {
  final Coupon coupon;

  CreateCouponEvent(this.coupon);

  @override
  List<Object?> get props => [coupon];
}

class ChangeImageEvent extends AddCouponEvent {
  final String image;

  ChangeImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class ChangeTypeEvent extends AddCouponEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeDateEvent extends AddCouponEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonEvent extends AddCouponEvent {
  final bool isContinue;

  SaveButtonEvent(this.isContinue);

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateCouponEvent extends AddCouponEvent {
  final Coupon coupon;

  UpdateCouponEvent(this.coupon);

  @override
  List<Object?> get props => [identityHashCode(this)];
}
