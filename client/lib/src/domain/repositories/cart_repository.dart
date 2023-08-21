import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/remote/response/order/order_response.dart';

import '../../core/request/cart_request/change_method_request.dart';

abstract class CartRepository {
  Future<DataState<OrderResponse>> placeOrder();

  Future<DataState<OrderResponse>> changeMethod(ChangeMethodRequest request);

  Future<DataState<OrderResponse>> deleteOrderSpending();

  Future<DataState<OrderResponse?>> deleteProduct(int index);

  Future<DataState<OrderResponse>> attachCouponToOrder(String id);

  Future<DataState<OrderResponse>> deleteCouponOrder();

  Future<DataState<OrderResponse>> addNote(String note);
}
