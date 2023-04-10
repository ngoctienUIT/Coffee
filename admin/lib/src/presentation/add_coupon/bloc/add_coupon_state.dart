abstract class AddCouponState {}

class InitState extends AddCouponState {}

class ChangeImageState extends AddCouponState {}

class ChangeTypeState extends AddCouponState {}

class ChangeDateState extends AddCouponState {}

class SaveButtonState extends AddCouponState {
  bool isContinue;

  SaveButtonState(this.isContinue);
}

class AddCouponLoadingState extends AddCouponState {}

class AddCouponSuccessState extends AddCouponState {}

class AddCouponErrorState extends AddCouponState {
  String status;

  AddCouponErrorState(this.status);
}
