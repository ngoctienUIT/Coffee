import 'package:coffee/injection.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';

import 'package:coffee/src/data/remote/response/order/order_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' as inject;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/request/cart_request/change_method_request.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/order.dart';
import '../models/user.dart';
import '../remote/firebase/firebase_service.dart';

@inject.LazySingleton(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  CartRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<OrderResponse>> attachCouponToOrder(String id) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      final response = await _apiService.attachCouponToOrder(
          "Bearer $token", id, getIt<Order>().orderId!);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.response?.data["message"].toString() ?? e.toString();
      print(error);
      return DataFailed(e.toString());
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<OrderResponse>> changeMethod(
      ChangeMethodRequest request) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      Order order = getIt<Order>();
      order.selectedPickupOption =
          request.isBringBack ? "DELIVERY" : "AT_STORE";
      _sharedPref.setBool("isBringBack", request.isBringBack);
      if (request.isBringBack) {
        String myAddress = _sharedPref.getString("address") ?? "";
        if (request.address != null) {
          order.addAddress(request.address!);
        } else if (myAddress.isNotEmpty) {
          order.addAddress(myAddress.toAddressAPI().toAddress());
        }
      } else {
        order.removeAddress();
        request.storeID ??=
            (_sharedPref.getString("storeID") ?? "6425d2c7cf1d264dca4bcc82");
        order.storeId = request.storeID;
        _sharedPref.setString("storeID", request.storeID!);
      }
      final orderResponse = await _apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), order.orderId!);
      return DataSuccess(orderResponse.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<OrderResponse>> deleteCouponOrder() async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      Order order = getIt<Order>();
      order.appliedCoupons = null;
      final response = await _apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), order.orderId!);

      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<OrderResponse>> deleteOrderSpending() async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      final response = await _apiService.removePendingOrder(
          "Bearer $token", getIt<User>().username);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<OrderResponse?>> deleteProduct(int index) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      Order order = getIt<Order>();
      order.orderItems.removeAt(index);
      if (order.orderItems.isEmpty) {
        await _apiService.removePendingOrder(
            "Bearer $token", getIt<User>().username);
        return DataSuccess(null);
      } else {
        final response = await _apiService.updatePendingOrder(
            "Bearer $token", order.toJson(), order.orderId!);
        return DataSuccess(response.data);
      }
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<OrderResponse>> placeOrder() async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      Order order = getIt<Order>();
      final response =
          await _apiService.placeOrder("Bearer $token", order.orderId!);
      sendPushMessageTopic(
        orderID: order.orderId!,
        body: "Đơn hàng ${order.orderId!} đã được đặt thành công",
        title: "Đơn hàng mới",
      );
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<OrderResponse>> addNote(String note) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      Order order = getIt<Order>();
      order.orderNote = note;
      final response = await _apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), order.orderId!);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
