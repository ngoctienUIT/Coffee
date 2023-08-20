import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../domain/use_cases/coupon_use_case/get_coupon.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

@injectable
class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final GetCouponUseCase _useCase;

  CouponBloc(this._useCase) : super(InitState()) {
    on<FetchData>(_fetchData);
  }

  Future _fetchData(FetchData event, Emitter emit) async {
    emit(CouponLoading());
    final response = await _useCase.call();
    if (response is DataSuccess) {
      emit(CouponLoaded(response.data!));
    } else {
      emit(CouponError(response.error));
    }
  }
}
