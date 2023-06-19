import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/item_order.dart';
import '../../../data/models/order.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Product product = Product(name: "", currency: "", price: 0, M: 0, L: 0);
  PreferencesModel preferencesModel;

  ProductBloc(this.preferencesModel) : super(InitState()) {
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
      emit(ProductLoadingState());
      if (preferencesModel.order == null) {
        await createNewOrder(product: product, emit: emit);
      } else {
        await updatePendingOrder(
            order: preferencesModel.order!, product: product, emit: emit);
      }
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductErrorState(error));
      print(error);
    } catch (e) {
      emit(ProductErrorState(e.toString()));
      print(e);
    }
  }

  Future createNewOrder({
    required Product product,
    required Emitter emit,
  }) async {
    try {
      String address = preferencesModel.address ?? "";
      bool isBringBack = preferencesModel.isBringBack;
      String? storeID = preferencesModel.storeID;

      if (storeID == null || storeID.isEmpty) {
        storeID = "6425d2c7cf1d264dca4bcc82";
        SharedPreferences.getInstance()
            .then((value) => value.setString("storeID", storeID!));
      }
      print(storeID);
      Order order = Order(
        userId: preferencesModel.user!.id!,
        storeId: storeID,
        selectedPickupOption: isBringBack ? "DELIVERY" : "AT_STORE",
        orderItems: [product.toItemOrder()],
      );

      if (isBringBack && address.isNotEmpty) {
        order.addAddress(address.toAddressAPI().toAddress());
      }
      final response = await preferencesModel.apiService
          .createNewOrder("Bearer ${preferencesModel.token}", order.toJson());
      emit(AddProductToOrderSuccessState(
          Order.fromOrderResponse(response.data)));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductErrorState(error));
      print(error);
    } catch (e) {
      emit(ProductErrorState(e.toString()));
      print(e);
    }
  }

  Future updatePendingOrder({
    required Order order,
    required Product product,
    required Emitter emit,
  }) async {
    try {
      // int index = order.orderItems.indexWhere((element) =>
      //     element.productId == product.id &&
      //     element.selectedSize == product.sizeIndex);
      int index = order.orderItems
          .indexWhere((element) => checkProduct(product, element));
      if (index == -1) {
        order.orderItems.add(product.toItemOrder());
      } else {
        order.orderItems[index].quantity += product.number;
      }
      order.storeId ??= "6425d2c7cf1d264dca4bcc82";
      print(order.toJson());
      final response = await preferencesModel.apiService.updatePendingOrder(
          "Bearer ${preferencesModel.token}", order.toJson(), order.orderId!);
      emit(AddProductToOrderSuccessState(
          Order.fromOrderResponse(response.data)));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductErrorState(error));
      print(error);
    } catch (e) {
      emit(ProductErrorState(e.toString()));
      print(e);
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

  Future updateProductOrder(int index, Product product, Emitter emit) async {
    try {
      emit(ProductLoadingState());
      print("update product");
      print(product.toItemOrder().toJson());
      Order order = preferencesModel.order!;
      order.orderItems[index].quantity = product.number;
      order.orderItems[index].selectedSize = product.sizeIndex;
      print(order.orderItems[index].toJson());

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
      print(order.toJson());

      final response = await preferencesModel.apiService.updatePendingOrder(
          "Bearer ${preferencesModel.token}", order.toJson(), order.orderId!);
      emit(UpdateSuccessState(Order.fromOrderResponse(response.data)));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductErrorState(error));
      print(error);
    } catch (e) {
      emit(ProductErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteProductOrder(int index, Emitter emit) async {
    try {
      emit(ProductLoadingState());
      Order? order = preferencesModel.order!;
      order.orderItems.removeAt(index);
      if (order.orderItems.isEmpty) {
        await preferencesModel.apiService.removePendingOrder(
            "Bearer ${preferencesModel.token}",
            preferencesModel.user!.username);
        order = null;
      } else {
        final response = await preferencesModel.apiService.updatePendingOrder(
            "Bearer ${preferencesModel.token}", order.toJson(), order.orderId!);
        order = Order.fromOrderResponse(response.data);
      }
      emit(DeleteSuccessState(order));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductErrorState(error));
      print(error);
    } catch (e) {
      emit(ProductErrorState(e.toString()));
      print(e);
    }
  }
}
