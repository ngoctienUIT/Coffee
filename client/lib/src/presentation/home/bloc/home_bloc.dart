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
      final listProductCatalogues = apiService.getAllProductCatalogues();
      emit(HomeLoaded(
        listCoupon: (await listCoupon).data,
        listProduct: (await listProduct).data,
        listProductCatalogues: (await listProductCatalogues).data,
      ));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(HomeError(error));
      print(error);
    } catch (e) {
      emit(HomeError(e.toString()));
      print(e);
    }
  }
}
