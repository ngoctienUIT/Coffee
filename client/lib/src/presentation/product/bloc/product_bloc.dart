import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../data/models/product.dart';
import '../../../domain/api_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Product product = Product(name: "", currency: "", price: 0, M: 0, L: 0);

  ProductBloc() : super(InitState()) {
    on<DataTransmissionEvent>((event, emit) {
      product = event.product.copyWith();
      emit(DataTransmissionState());
    });

    on<AddProductToOrderEvent>(
        (event, emit) => addProductToOrder(event.product, emit));

    on<UpdateProductEvent>(
        (event, emit) => updateProductOrder(event.index, event.product, emit));

    on<DeleteProductEvent>(
        (event, emit) => deleteProductOrder(event.index, emit));
  }

  Future addProductToOrder(Product product, Emitter emit) async {
    try {
      emit(AddProductToOrderLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      String userID = prefs.getString("userID") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      final orderSpending = response.data;
      if (orderSpending.isEmpty) {
        await createNewOrder(
            token: token, userID: userID, product: product, emit: emit);
      } else {
        await updatePendingOrder(
          token: token,
          order: Order.fromOrderResponse(orderSpending[0]),
          product: product,
          emit: emit,
        );
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductToOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(AddProductToOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future createNewOrder({
    required String token,
    required String userID,
    required Product product,
    required Emitter emit,
  }) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String? storeID = prefs.getString("storeID");
      String address = prefs.getString("address") ?? "";
      bool isBringBack = prefs.getBool("isBringBack") ?? false;
      if (storeID == null || storeID.isEmpty) {
        prefs.setString("storeID", "6425d2c7cf1d264dca4bcc82");
        storeID = "6425d2c7cf1d264dca4bcc82";
      }
      print(storeID);
      Order order = Order(
        userId: userID,
        storeId: storeID,
        selectedPickupOption: isBringBack ? "DELIVERY" : "AT_STORE",
        orderItems: [product.toItemOrder()],
      );

      if (isBringBack && address.isNotEmpty) {
        order.addAddress(address.toAddressAPI().toAddress());
      }
      await apiService.createNewOrder("Bearer $token", order.toJson());
      emit(AddProductToOrderSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductToOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(AddProductToOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future updatePendingOrder({
    required String token,
    required Order order,
    required Product product,
    required Emitter emit,
  }) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      int index = order.orderItems.indexWhere((element) =>
          element.productId == product.id &&
          element.selectedSize == product.sizeIndex);
      if (index == -1) {
        order.orderItems.add(product.toItemOrder());
      } else {
        order.orderItems[index].quantity += product.number;
      }
      order.storeId ??= "6425d2c7cf1d264dca4bcc82";
      print(order.toJson());
      await apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), order.orderId!);
      emit(AddProductToOrderSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductToOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(AddProductToOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future updateProductOrder(int index, Product product, Emitter emit) async {
    try {
      emit(UpdateLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      final orderSpending = response.data;
      Order order = Order.fromOrderResponse(orderSpending[0]);

      order.orderItems[index].quantity = product.number;
      order.orderItems[index].selectedSize = product.sizeIndex;

      if (product.toppingOptions != null) {
        List<String> list = [];
        for (int i = 0; i < product.chooseTopping!.length; i++) {
          if (product.chooseTopping![i]) {
            list.add(product.toppingOptions![i].toppingId);
          }
        }
        order.orderItems[index].toppingIds = list;
      }
      order.storeId ??= "6425d2c7cf1d264dca4bcc82";
      await apiService.updatePendingOrder(
          "Bearer $token", order.toJson(), order.orderId!);
      emit(UpdateSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(UpdateErrorState(error));
      print(error);
    } catch (e) {
      emit(UpdateErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteProductOrder(int index, Emitter emit) async {
    try {
      emit(DeleteLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      final orderSpending = response.data;
      Order order = Order.fromOrderResponse(orderSpending[0]);
      order.orderItems.removeAt(index);

      if (order.orderItems.isEmpty) {
        await apiService.removePendingOrder("Bearer $token", email);
      } else {
        await apiService.updatePendingOrder(
            "Bearer $token", order.toJson(), order.orderId!);
      }
      emit(DeleteSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(DeleteErrorState(error));
      print(error);
    } catch (e) {
      emit(DeleteErrorState(e.toString()));
      print(e);
    }
  }
}
