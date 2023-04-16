import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/order.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        address: event.address));

    on<AttachCouponToOrder>(
        (event, emit) => attachCouponToOrder(event.id, emit));

    on<DeleteCouponOrder>((event, emit) => deleteCouponOrder(emit));

    on<PlaceOrder>((event, emit) => placeOrder(emit));

    on<AddNote>((event, emit) => addNote(event.note));
  }

  Future addNote(String note) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      List<OrderResponse> orderSpending = response.data;
      Order order = Order.fromOrderResponse(orderSpending[0]);
      order.orderNote = note;

      await apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), order.orderId!);
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
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
      emit(GetOrderSuccessState(null));
      Fluttertoast.showToast(msg: "Đặt hàng thành công");
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
      prefs.setBool("isBringBack", isBringBack);
      print(order.selectedPickupOption);
      if (isBringBack) {
        String myAddress = prefs.getString("address") ?? "";
        if (address != null) {
          order.addAddress(address);
        } else if (myAddress.isNotEmpty) {
          order.addAddress(myAddress.toAddressAPI().toAddress());
        }
        // order.storeId = null;
        // print(order.storeId);
      } else {
        order.removeAddress();
        storeID ??= (prefs.getString("storeID") ?? "6425d2c7cf1d264dca4bcc82");
        order.storeId = storeID;
        prefs.setString("storeID", storeID);
      }
      final orderResponse = await apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), order.orderId!);
      emit(GetOrderSuccessState(orderResponse.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
        print(orderSpending[0].toJson());
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteOrderSpending(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";

      await apiService.removePendingOrder("Bearer $token", email);
      emit(GetOrderSuccessState(null));
      Fluttertoast.showToast(msg: "Xóa giỏ hàng thành công");
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteProduct(String id, Emitter emit) async {
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
      order.orderItems =
          order.orderItems.where((element) => element.productId != id).toList();
      if (order.orderItems.isEmpty) {
        await apiService.removePendingOrder("Bearer $token", email);
        emit(GetOrderSuccessState(null));
      } else {
        emit(GetOrderSuccessState((await apiService.updatePendingOrder(
                "Bearer $token", order.toJson(), order.orderId!))
            .data));
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(GetOrderErrorState(e.toString()));
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
          "Bearer $token", id, orderSpending[0].orderId!);
      emit(GetOrderSuccessState(responseCoupon.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteCouponOrder(Emitter emit) async {
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
      Order order = Order.fromOrderResponse(orderSpending[0]);
      order.appliedCoupons = null;
      final responseCoupon = await apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), orderSpending[0].orderId!);

      emit(GetOrderSuccessState(responseCoupon.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }
}
