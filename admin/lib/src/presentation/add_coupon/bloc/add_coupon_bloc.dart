import 'package:coffee_admin/src/core/request/coupon_request/coupon_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/coupon_use_case/create_coupon.dart';
import '../../../domain/use_cases/coupon_use_case/update_coupon.dart';
import 'add_coupon_event.dart';
import 'add_coupon_state.dart';

@injectable
class AddCouponBloc extends Bloc<AddCouponEvent, AddCouponState> {
  String image = "";
  final CreateCouponUseCase _createCouponUseCase;
  final UpdateCouponUseCase _updateCouponUseCase;

  AddCouponBloc(this._createCouponUseCase, this._updateCouponUseCase)
      : super(InitState()) {
    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<ChangeTypeEvent>((event, emit) => emit(ChangeTypeState()));

    on<ChangeDateEvent>((event, emit) => emit(ChangeDateState()));

    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateCouponEvent>(_createCoupon);

    on<UpdateCouponEvent>(_updateCoupon);
  }

  Future _createCoupon(CreateCouponEvent event, Emitter emit) async {
    emit(AddCouponLoadingState());
    final response = await _createCouponUseCase.call(
        params: CouponRequest(image: image, coupon: event.coupon));
    if (response is DataSuccess) {
      emit(AddCouponSuccessState());
    } else {
      emit(AddCouponErrorState(response.error ?? ""));
    }
  }

  Future _updateCoupon(UpdateCouponEvent event, Emitter emit) async {
    emit(AddCouponLoadingState());
    final response = await _updateCouponUseCase.call(
        params: CouponRequest(image: image, coupon: event.coupon));
    if (response is DataSuccess) {
      emit(AddCouponSuccessState());
    } else {
      emit(AddCouponErrorState(response.error ?? ""));
    }
  }
}
