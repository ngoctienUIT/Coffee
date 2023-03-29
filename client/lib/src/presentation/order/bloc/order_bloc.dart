import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(OrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final listProduct = await apiService.getAllProducts();
      final listProductCatalogues = await apiService.getAllProductCatalogues();

      emit(OrderLoaded(listProduct, listProductCatalogues));
    } catch (e) {
      emit(OrderError(e.toString()));
      print(e);
    }
  }
}
