import 'package:coffee/injection.dart';
import 'package:coffee/src/core/request/product_request/delete_product_in_order_request.dart';
import 'package:coffee/src/core/request/product_request/update_order_request.dart';
import 'package:coffee/src/core/request/product_request/update_product_in_order_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/order.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' as inject;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/product_repository.dart';
import '../models/item_order.dart';
import '../models/product.dart';

@inject.LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(this._apiService, this._prefs);

  final ApiService _apiService;
  final SharedPreferences _prefs;

  @override
  Future<DataState<Order?>> createNewOrder(Product product) async {
    try {
      String address = _prefs.getString("address") ?? "";
      String token = _prefs.getString("token") ?? "";
      bool isBringBack = _prefs.getBool("isBringBack") ?? false;
      String? storeID = _prefs.getString("storeID");
      User user = getIt<User>();

      if (storeID == null || storeID.isEmpty) {
        storeID = "6425d2c7cf1d264dca4bcc82";
        SharedPreferences.getInstance()
            .then((value) => value.setString("storeID", storeID!));
      }
      print(storeID);
      Order order = Order(
        userId: user.id ?? "",
        storeId: storeID,
        selectedPickupOption: isBringBack ? "DELIVERY" : "AT_STORE",
        orderItems: [product.toItemOrder()],
      );

      if (isBringBack && address.isNotEmpty) {
        order.addAddress(address.toAddressAPI().toAddress());
      }
      final response =
          await _apiService.createNewOrder("Bearer $token", order.toJson());
      return DataSuccess(Order.fromOrderResponse(response.data));
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
  Future<DataState<Order?>> updatePendingOrder(
      UpdateOrderRequest request) async {
    try {
      String token = _prefs.getString("token") ?? "";
      int index = request.order.orderItems
          .indexWhere((element) => checkProduct(request.product, element));
      if (index == -1) {
        request.order.orderItems.add(request.product.toItemOrder());
      } else {
        request.order.orderItems[index].quantity += request.product.number;
      }
      request.order.storeId ??= "6425d2c7cf1d264dca4bcc82";
      print(request.order.toJson());
      final response = await _apiService.updatePendingOrder(
          "Bearer $token", request.order.toJson(), request.order.orderId!);
      return DataSuccess(Order.fromOrderResponse(response.data));
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  bool checkProduct(Product product1, ItemOrder product2) {
    if (product1.id != product2.productId) return false;
    if (product1.sizeIndex != product2.selectedSize) return false;
    if (product1.chooseTopping != null) {
      for (int i = 0; i < product1.chooseTopping!.length; i++) {
        if (product1.chooseTopping![i] &&
            !product2.toppingIds
                .contains(product1.toppingOptions![i].toppingId)) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Future<DataState<Order?>> updateProductInOrder(
      UpdateProductInOrderRequest request) async {
    try {
      String token = _prefs.getString("token") ?? "";
      request.order.orderItems[request.index].quantity = request.product.number;
      request.order.orderItems[request.index].selectedSize =
          request.product.sizeIndex;
      print(request.order.orderItems[request.index].toJson());

      if (request.product.toppingOptions != null) {
        List<String> list = [];
        for (int i = 0; i < request.product.chooseTopping!.length; i++) {
          if (request.product.chooseTopping![i]) {
            list.add(request.product.toppingOptions![i].toppingId);
          }
        }
        request.order.orderItems[request.index].toppingIds = list;
      }
      request.order.storeId ??= "6425d2c7cf1d264dca4bcc82";
      print(request.order.toJson());

      final response = await _apiService.updatePendingOrder(
          "Bearer $token", request.order.toJson(), request.order.orderId!);
      return DataSuccess(Order.fromOrderResponse(response.data));
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
  Future<DataState<Order?>> deleteProductInOrder(
      DeleteProductInOrderRequest request) async {
    try {
      String token = _prefs.getString("token") ?? "";
      User user = getIt<User>();
      Order? order = request.order;
      order.orderItems.removeAt(request.index);
      if (order.orderItems.isEmpty) {
        await _apiService.removePendingOrder("Bearer $token", user.username);
        order = null;
      } else {
        final response = await _apiService.updatePendingOrder(
            "Bearer $token", order.toJson(), order.orderId!);
        order = Order.fromOrderResponse(response.data);
      }
      return DataSuccess(order);
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
