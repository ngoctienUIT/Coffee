import 'package:coffee/src/core/resources/data_state.dart';

import '../../data/remote/response/order/order_response.dart';

abstract class ActivityRepository {
  Future<DataState<List<OrderResponse>>> getData(int index);
}
