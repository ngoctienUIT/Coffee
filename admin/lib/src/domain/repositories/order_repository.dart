import 'package:coffee_admin/src/core/resources/data_state.dart';

import '../../core/request/order_request/order_request.dart';
import '../../core/response/order_response/get_order_response.dart';
import '../../data/remote/response/order/order_response.dart';

abstract class OrderRepository {
  Future<DataState<List<OrderResponse>>> getListOrder(String status);

  Future<DataState<GetOrderResponse>> getOrderByID(String id);

  Future<DataState<OrderResponse>> cancelOrder(OrderRequest request);

  Future<DataState<OrderResponse>> orderCompleted(OrderRequest request);
}
