import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(HomeLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final listProduct = apiService.getAllProducts();
      final listCoupon = apiService.getAllCoupons();
      emit(HomeLoaded(
        listCoupon: await listCoupon,
        listProduct: await listProduct,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
      print(e);
    }
  }
}
