abstract class CartEvent {}

class GetOrderSpending extends CartEvent {}

class DeleteOrderEvent extends CartEvent {}

class DeleteProductEvent extends CartEvent {
  String id;

  DeleteProductEvent(this.id);
}

class AttachCouponToOrder extends CartEvent {
  String id;

  AttachCouponToOrder(this.id);
}

class ChangeMethod extends CartEvent {
  bool isBringBack;

  ChangeMethod(this.isBringBack);
}
