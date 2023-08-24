import 'package:equatable/equatable.dart';

abstract class AddCouponState extends Equatable {}

class InitState extends AddCouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeImageState extends AddCouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeTypeState extends AddCouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeDateState extends AddCouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveButtonState extends AddCouponState {
  final bool isContinue;

  SaveButtonState(this.isContinue);

  @override
  List<Object?> get props => [isContinue];
}

class AddCouponLoadingState extends AddCouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddCouponSuccessState extends AddCouponState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddCouponErrorState extends AddCouponState {
  final String status;

  AddCouponErrorState(this.status);

  @override
  List<Object?> get props => [status];
}
