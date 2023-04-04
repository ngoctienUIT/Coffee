import '../../../data/models/coupon.dart';

abstract class AddCouponEvent {}

class CreateCouponEvent extends AddCouponEvent {
  Coupon coupon;

  CreateCouponEvent(this.coupon);
}

class ChangeImageEvent extends AddCouponEvent {}

class ChangeDateEvent extends AddCouponEvent {}

class SaveButtonEvent extends AddCouponEvent {
  bool isContinue;

  SaveButtonEvent(this.isContinue);
}

class UpdateCouponEvent extends AddCouponEvent {
  Coupon coupon;

  UpdateCouponEvent(this.coupon);
}
