import 'package:coffee/src/data/models/item_order.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../domain/api_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitState()) {
    on<DataTransmissionEvent>(
        (event, emit) => emit(DataTransmissionState(event.product)));

    on<AddProductToOrderEvent>(
        (event, emit) => addProductToOrder(event.product, emit));
  }

  Future addProductToOrder(Product product, Emitter emit) async {
    // try {
    emit(AddProductToOrderLoadingState());
    ApiService apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    String email = prefs.getString("username") ?? "";
    String userID = prefs.getString("userID") ?? "";
    print(token);
    print(userID);
    print(email);
    final orderSpending =
        await apiService.getAllOrders("Bearer $token", email, "PENDING");
    if (orderSpending.isEmpty) {
      await createNewOrder(token, userID, product, emit);
    } else {
      // Todo đã có order sẵn chỉ cần thêm vào giỏ
    }
    // } catch (e) {
    //   emit(AddProductToOrderErrorState(e.toString()));
    //   print(e);
    // }
  }

  Future createNewOrder(
      String token, String userID, Product product, Emitter emit) async {
    ApiService apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    final response = await apiService.createNewOrder(
      "Bearer $token",
      Order(
        userId: userID,
        storeId: "6425d2c7cf1d264dca4bcc82",
        orderItems: [
          ItemOrder(
            productId: product.id,
            quantity: product.number,
            toppingIds: product.toppingOptions == null
                ? []
                : product.toppingOptions!.map((e) => e.toppingId).toList(),
            selectedSize: product.sizeIndex == 0
                ? "S"
                : (product.sizeIndex == 1 ? "M" : "L"),
          ),
        ],
      ).toJson(),
    );
    Fluttertoast.showToast(msg: "Thêm sản phẩm vào giỏ hàng thành công");
    emit(AddProductToOrderSuccessState());
  }
}
