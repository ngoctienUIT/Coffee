abstract class CartEvent {}

class GetOrderSpending extends CartEvent {}

class DeleteOrderEvent extends CartEvent {}

class DeleteProductEvent extends CartEvent {
  String id;

  DeleteProductEvent(this.id);
}
