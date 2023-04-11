import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
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
      String? storeID = prefs.getString("storeID");
      bool isBringBack = prefs.getBool("isBringBack") ?? true;
      final orderResponse =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      final store =
          storeID == null ? null : await apiService.getStoreByID(storeID);

      emit(OrderLoaded(
        index: 0,
        listProduct: listProduct,
        listProductCatalogues: listProductCatalogues,
        order: orderResponse.data.isEmpty ? null : orderResponse.data[0],
        store: storeID == null ? null : store!.data,
        isBringBack: isBringBack,
      ));
    } catch (e) {
      emit(OrderError(serverStatus(e)!));
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
      emit(RefreshOrderError(serverStatus(e)));
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
      String? storeID = prefs.getString("storeID");
      bool isBringBack = prefs.getBool("isBringBack") ?? true;

      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      final store =
          storeID == null ? null : await apiService.getStoreByID(storeID);

      emit(AddProductToCartLoaded(
        response.data.isEmpty ? null : response.data[0],
        storeID == null ? null : store!.data,
        isBringBack,
      ));
    } catch (e) {
      emit(AddProductToCartError(serverStatus(e)));
      print(e);
    }
  }
}
