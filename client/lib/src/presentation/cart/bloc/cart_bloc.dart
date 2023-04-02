import 'package:coffee/src/data/models/order.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitState()) {
    on<GetOrderSpending>((event, emit) => getOrderSpending(emit));

    on<DeleteOrderEvent>((event, emit) => deleteOrderSpending(emit));

    on<DeleteProductEvent>((event, emit) => deleteProduct(event.id, emit));
  }

  Future getOrderSpending(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      String userID = prefs.getString("userID") ?? "";
      final orderSpending =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");

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
      final orderSpending =
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
      final orderSpending =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      Order order = Order.fromOrderResponse(orderSpending[0]);
      order.orderItems =
          order.orderItems.where((element) => element.productId != id).toList();
      if (order.orderItems.isEmpty) {
        final orderSpending =
            await apiService.removePendingOrder("Bearer $token", email);
      } else {
        final response = await apiService.updatePendingOrder(
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
}
