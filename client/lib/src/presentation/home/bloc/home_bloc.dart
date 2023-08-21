import 'package:coffee/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/coupon_use_case/get_coupon.dart';
import '../../../domain/use_cases/home_use_case/get_order_spending.dart';
import '../../../domain/use_cases/home_use_case/get_recommend.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCouponUseCase _getCouponUseCase;
  final GetOrderSpendingUseCase _getOrderSpendingUseCase;
  final GetRecommendUseCase _getRecommendUseCase;

  HomeBloc(
    this._getRecommendUseCase,
    this._getOrderSpendingUseCase,
    this._getCouponUseCase,
  ) : super(InitState()) {
    on<FetchData>(_getData);

    on<GetCouponEvent>(_getCoupon);

    on<GetOrderSpendingEvent>(_getOrderSpending);

    on<ChangeBannerEvent>((event, emit) => emit(ChangeBannerState()));
  }

  Future _getData(FetchData event, Emitter emit) async {
    emit(HomeLoading(event.check));
    final response = await _getRecommendUseCase.call();
    if (response is DataSuccess) {
      emit(HomeLoaded(
        user: response.data!.user,
        listProduct: response.data!.listProduct,
        weather: response.data!.weather,
        address: response.data!.address,
      ));
    } else {
      emit(HomeError(response.error));
    }
  }

  Future _getOrderSpending(GetOrderSpendingEvent event, Emitter emit) async {
    final response = await _getOrderSpendingUseCase.call();
    if (response is DataSuccess) {
      emit(CartLoaded(response.data));
    } else {
      emit(HomeError(response.error));
    }
  }

  Future _getCoupon(GetCouponEvent event, Emitter emit) async {
    final response = await _getCouponUseCase.call();
    if (response is DataSuccess) {
      emit(CouponLoaded(listCoupon: response.data!));
    } else {
      emit(HomeError(response.error));
    }
  }
}
