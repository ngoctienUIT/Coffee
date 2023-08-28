import 'package:coffee/src/core/resources/data_state.dart';

import '../../data/remote/response/order/order_response.dart';

abstract class ViewOrderRepository {
  Future<DataState<OrderResponse>> getData(String id);

  Future<DataState<OrderResponse>> cancelOrder(String id);
}
