import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<ProductCataloguesResponse> listProductCatalogues = [];

  OrderBloc() : super(InitState()) {
    on<FetchData>((event, emit) => fetchData(emit));

    on<RefreshData>((event, emit) => refreshData(event.index, emit));

    on<AddProductToCart>((event, emit) => getOrderSpending(emit));
  }

  Future fetchData(Emitter emit) async {
    try {
      emit(OrderLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllProductCatalogues();
      listProductCatalogues = response.data;

      final productResponse = await apiService
          .getAllProductsFromProductCatalogueID(listProductCatalogues[0].id);
      final listProduct = productResponse.data;
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final orderResponse =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");

      emit(OrderLoaded(0, listProduct, listProductCatalogues,
          orderResponse.data.isEmpty ? null : orderResponse.data[0]));
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
      final response = await apiService.getAllProductsFromProductCatalogueID(
          listProductCatalogues[index].id);
      final listProduct = response.data;

      emit(RefreshOrderLoaded(index, listProduct));
    } catch (e) {
      emit(RefreshOrderError(e.toString()));
      print(e);
    }
  }

  Future getOrderSpending(Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");

      emit(AddProductToCartLoaded(
          response.data.isEmpty ? null : response.data[0]));
    } catch (e) {
      emit(AddProductToCartError(e.toString()));
      print(e);
    }
  }
}
