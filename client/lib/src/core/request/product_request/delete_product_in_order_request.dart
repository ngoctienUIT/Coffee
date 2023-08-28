import '../../../data/models/order.dart';

class DeleteProductInOrderRequest {
  final int index;
  final Order order;

  DeleteProductInOrderRequest(this.index, this.order);
}
