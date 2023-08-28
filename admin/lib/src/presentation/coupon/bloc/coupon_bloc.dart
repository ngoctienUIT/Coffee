import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/coupon_use_case/delete_coupon.dart';
import '../../../domain/use_cases/coupon_use_case/get_all_coupon.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

@injectable
class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final GetAllCouponUseCase _getAllCouponUseCase;
  final DeleteCouponUseCase _deleteCouponUseCase;

  CouponBloc(this._getAllCouponUseCase, this._deleteCouponUseCase)
      : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<DeleteEvent>(_deleteCoupon);
  }

  Future getData(bool check, Emitter emit) async {
    if (check) emit(CouponLoading());
    final response = await _getAllCouponUseCase.call();
    if (response is DataSuccess) {
      emit(CouponLoaded(response.data!));
    } else {
      emit(CouponError(response.error));
    }
  }

  Future _deleteCoupon(DeleteEvent event, Emitter emit) async {
    emit(CouponLoading(false));
    final response = await _deleteCouponUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(DeleteCouponSuccess(event.id));
    } else {
      emit(CouponError(response.error));
    }
  }
}
