import 'package:coffee/src/core/request/product_request/update_order_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/models/order.dart';

import '../../core/request/product_request/delete_product_in_order_request.dart';
import '../../core/request/product_request/update_product_in_order_request.dart';
import '../../data/models/product.dart';

abstract class ProductRepository {
  Future<DataState<Order?>> createNewOrder(Product product);

  Future<DataState<Order?>> updatePendingOrder(UpdateOrderRequest request);

  Future<DataState<Order?>> updateProductInOrder(
      UpdateProductInOrderRequest request);

  Future<DataState<Order?>> deleteProductInOrder(
      DeleteProductInOrderRequest request);
}
