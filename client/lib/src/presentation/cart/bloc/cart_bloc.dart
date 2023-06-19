import 'package:coffee/src/core/utils/enum/enums.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/order.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/address.dart';
import '../../../data/models/preferences_model.dart';
import '../../../domain/firebase/firebase_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  PreferencesModel preferencesModel;

  CartBloc(this.preferencesModel) : super(InitState()) {
    on<GetOrderSpending>((event, emit) => getOrderSpending(emit));

    on<SetPreferencesModel>((event, emit) {
      preferencesModel = event.preferencesModel.copyWith();
    });

    on<DeleteOrderEvent>((event, emit) => deleteOrderSpending(emit));

    on<DeleteProductEvent>((event, emit) => deleteProduct(event.index, emit));

    on<ChangeMethod>((event, emit) => changeMethod(
          isBringBack: event.isBringBack,
          emit: emit,
          storeID: event.storeID,
          address: event.address,
        ));

    on<AttachCouponToOrder>(
        (event, emit) => attachCouponToOrder(event.id, emit));

    on<DeleteCouponOrder>((event, emit) => deleteCouponOrder(emit));

    on<PlaceOrder>((event, emit) => placeOrder(emit));

    on<AddNote>((event, emit) => addNote(event.note, emit));
  }

  Future addNote(String note, Emitter emit) async {
    try {
      Order order = preferencesModel.order!;
      order.orderNote = note;

      await preferencesModel.apiService.updatePendingOrder(
          "Bearer ${preferencesModel.token}", order.toJson(), order.orderId!);
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future placeOrder(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      await preferencesModel.apiService.placeOrder(
          "Bearer ${preferencesModel.token}", preferencesModel.order!.orderId!);
      emit(GetOrderSuccessState(null, OrderStatus.placed));
      sendPushMessageTopic(
        orderID: preferencesModel.order!.orderId!,
        body:
            "Đơn hàng ${preferencesModel.order!.orderId!} đã được đặt thành công",
        title: "Đơn hàng mới",
      );
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
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
      final prefs = await SharedPreferences.getInstance();
      Order order = preferencesModel.order!;
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
      emit(ChangeStoreCartState());
      final orderResponse = await preferencesModel.apiService
          .updatePendingOrder("Bearer ${preferencesModel.token}",
              order.toJson(), order.orderId!);
      emit(GetOrderSuccessState(Order.fromOrderResponse(orderResponse.data)));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future getOrderSpending(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      emit(GetOrderSuccessState(preferencesModel.order));
      // ApiService apiService =
      //     ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final response = await apiService.getAllOrders(
      //   "Bearer ${preferencesModel.token}",
      //   preferencesModel.user!.username,
      //   "PENDING",
      // );
      // List<OrderResponse> orderSpending = response.data;
      // if (orderSpending.isEmpty) {
      //   emit(GetOrderSuccessState(null));
      // } else {
      //   print(orderSpending[0].toJson());
      //   Order order = Order.fromOrderResponse(orderSpending[0]);
      //   if (order != preferencesModel.order) {
      //     // preferencesModel.order = order.copyWith();
      //     emit(GetOrderSuccessState(order, null, false));
      //   }
      // }
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteOrderSpending(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      await preferencesModel.apiService.removePendingOrder(
          "Bearer ${preferencesModel.token}", preferencesModel.user!.username);
      emit(GetOrderSuccessState(null, OrderStatus.delete));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteProduct(int index, Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      Order order = preferencesModel.order!;
      // order.orderItems =
      //     order.orderItems.where((element) => element.productId != id).toList();
      order.orderItems.removeAt(index);
      if (order.orderItems.isEmpty) {
        await preferencesModel.apiService.removePendingOrder(
            "Bearer ${preferencesModel.token}",
            preferencesModel.user!.username);
        emit(GetOrderSuccessState(null, OrderStatus.delete));
      } else {
        emit(GetOrderSuccessState(Order.fromOrderResponse(
            (await preferencesModel.apiService.updatePendingOrder(
                    "Bearer ${preferencesModel.token}",
                    order.toJson(),
                    order.orderId!))
                .data)));
      }
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future attachCouponToOrder(String id, Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      final responseCoupon =
          await preferencesModel.apiService.attachCouponToOrder(
        "Bearer ${preferencesModel.token}",
        id,
        preferencesModel.order!.orderId!,
      );
      emit(GetOrderSuccessState(Order.fromOrderResponse(responseCoupon.data)));
    } on DioException catch (e) {
      String error = e.response != null
          ? e.response!.data["message"].toString()
          : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }

  Future deleteCouponOrder(Emitter emit) async {
    try {
      emit(GetOrderLoadingState());
      Order order = preferencesModel.order!;
      order.appliedCoupons = null;
      final responseCoupon = await preferencesModel.apiService
          .updatePendingOrder("Bearer ${preferencesModel.token}",
              order.toJson(), order.orderId!);

      emit(GetOrderSuccessState(Order.fromOrderResponse(responseCoupon.data)));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(GetOrderErrorState(error));
      print(error);
    } catch (e) {
      emit(GetOrderErrorState(e.toString()));
      print(e);
    }
  }
}
