import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/repositories/order/order_response.dart';
import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../domain/api_service.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<ProductCataloguesResponse> listProductCatalogues = [];

  OrderBloc() : super(InitState()) {
    on<FetchData>((event, emit) => fetchData(emit));

    on<RefreshData>((event, emit) => refreshData(event.index, emit));

    on<AddProductToCart>(
        (event, emit) => getOrderSpending(event.isChange, emit));
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
      String storeID = prefs.getString("storeID") ?? "";
      String address = prefs.getString("address") ?? "";
      bool isBringBack = prefs.getBool("isBringBack") ?? false;
      final orderResponse =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      final store =
          storeID.isEmpty ? null : await apiService.getStoreByID(storeID);

      emit(OrderLoaded(
        index: 0,
        listProduct: listProduct,
        listProductCatalogues: listProductCatalogues,
        order: orderResponse.data.isEmpty ? null : orderResponse.data[0],
        store: storeID.isEmpty ? null : store!.data,
        isBringBack: isBringBack,
        address: address,
      ));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OrderError(error));
      print(error);
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
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(RefreshOrderError(error));
      print(error);
    } catch (e) {
      emit(RefreshOrderError(e.toString()));
      print(e);
    }
  }

  Future getOrderSpending(bool isChange, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      String storeID = prefs.getString("storeID") ?? "";
      String address = prefs.getString("address") ?? "";
      bool isBringBack = prefs.getBool("isBringBack") ?? false;

      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      OrderResponse? myOrder = response.data.isEmpty ? null : response.data[0];

      if (isChange && myOrder != null) {
        Order order = Order.fromOrderResponse(myOrder);
        order.selectedPickupOption = isBringBack ? "DELIVERY" : "AT_STORE";
        if (isBringBack) {
          if (address.isNotEmpty) {
            order.addAddress(address.toAddressAPI().toAddress());
          } else {
            order.removeAddress();
          }
          // order.storeId = null;
          // print(order.storeId);
        } else {
          order.removeAddress();
          if (storeID.isEmpty) {
            storeID = "6425d2c7cf1d264dca4bcc82";
            prefs.setString("storeID", "6425d2c7cf1d264dca4bcc82");
          }
          order.storeId = storeID;
        }
        final orderResponse = await apiService.updatePendingOrder(
            "Bearer $token", order.toJson(), order.orderId!);
        myOrder = orderResponse.data;
      }
      final store =
          storeID.isEmpty ? null : await apiService.getStoreByID(storeID);

      emit(AddProductToCartLoaded(
          myOrder, storeID.isEmpty ? null : store!.data, isBringBack, address));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductToCartError(error));
      print(error);
    } catch (e) {
      emit(AddProductToCartError(e.toString()));
      print(e);
    }
  }
}
