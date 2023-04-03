import 'package:coffee/src/data/models/order.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/address.dart';
import '../../../domain/api_service.dart';
import '../../../domain/repositories/order/order_response.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitState()) {
    on<GetOrderSpending>((event, emit) => getOrderSpending(emit));

    on<DeleteOrderEvent>((event, emit) => deleteOrderSpending(emit));

    on<DeleteProductEvent>((event, emit) => deleteProduct(event.id, emit));

    on<ChangeMethod>((event, emit) => changeMethod(
          isBringBack: event.isBringBack,
          emit: emit,
          storeID: event.storeID,
          address: event.address,
        ));

    on<AttachCouponToOrder>(
        (event, emit) => attachCouponToOrder(event.id, emit));

    on<PlaceOrder>((event, emit) => placeOrder(emit));
  }

  Future placeOrder(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      List<OrderResponse> orderSpending = response.data;
      await apiService.placeOrder("Bearer $token", orderSpending[0].orderId!);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future changeMethod({
    required bool isBringBack,
    required Emitter emit,
    Address? address,
    String? storeID,
  }) async {
    try {
      emit(GetOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      List<OrderResponse> orderSpending = response.data;
      Order order = Order.fromOrderResponse(orderSpending[0]);
      order.selectedPickupOption = isBringBack ? "DELIVERY" : "AT_STORE";
      print(order.selectedPickupOption);
      // if (isBringBack) {
      //   order.addAddress(address!);
      //   // order.storeId = null;
      //   print(order.storeId);
      // } else {
      //   order.removeAddress();
      //   order.storeId = storeID;
      // }
      await apiService.updatePendingOrder(
        "Bearer $token",
        order.toJson(),
        order.orderId!,
      );
      // getOrderSpending(emit);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future getOrderSpending(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      List<OrderResponse> orderSpending = response.data;
      if (orderSpending.isEmpty) {
        emit(GetOrderSuccessState(null));
      } else {
        emit(GetOrderSuccessState(orderSpending[0]));
      }
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteOrderSpending(Emitter emit) async {
    try {
      emit(RemoveOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";

      await apiService.removePendingOrder("Bearer $token", email);
      emit(RemoveOrderSuccessState());
    } catch (e) {
      emit(RemoveOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteProduct(String id, Emitter emit) async {
    try {
      emit(DeleteProductLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      List<OrderResponse> orderSpending = response.data;
      Order order = Order.fromOrderResponse(orderSpending[0]);
      order.orderItems =
          order.orderItems.where((element) => element.productId != id).toList();
      if (order.orderItems.isEmpty) {
        apiService.removePendingOrder("Bearer $token", email);
      } else {
        await apiService.updatePendingOrder(
          "Bearer $token",
          order.toJson(),
          order.orderId!,
        );
      }
      emit(DeleteProductSuccessState(id));
    } catch (e) {
      emit(DeleteProductErrorState(e.toString()));
      print(e);
    }
  }

  Future attachCouponToOrder(String id, Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      final orderSpending = response.data;
      final responseCoupon = await apiService.attachCouponToOrder(
          "Bearer $token", orderSpending[0].orderId!, id);
      emit(GetOrderSuccessState(responseCoupon.data));
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }
}
