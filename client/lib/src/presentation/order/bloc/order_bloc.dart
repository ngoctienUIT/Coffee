import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<ProductCataloguesResponse> listProductCatalogues = [];

  OrderBloc() : super(InitState()) {
    on<FetchData>((event, emit) => fetchData(emit));

    on<RefreshData>((event, emit) => refreshData(event.index, emit));
  }

  Future fetchData(Emitter emit) async {
    try {
      emit(OrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      listProductCatalogues = await apiService.getAllProductCatalogues();

      final listProduct = await apiService
          .getAllProductsFromProductCatalogueID(listProductCatalogues[0].id);

      emit(OrderLoaded(0, listProduct, listProductCatalogues));
    } catch (e) {
      emit(OrderError(e.toString()));
      print(e);
    }
  }

  Future refreshData(int index, Emitter emit) async {
    try {
      emit(RefreshOrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final listProduct = await apiService.getAllProductsFromProductCatalogueID(
          listProductCatalogues[index].id);

      emit(RefreshOrderLoaded(index, listProduct));
    } catch (e) {
      emit(RefreshOrderError(e.toString()));
      print(e);
    }
  }
}
