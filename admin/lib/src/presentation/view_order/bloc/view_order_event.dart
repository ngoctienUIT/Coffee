abstract class ViewOrderEvent {}

class CancelOrderEvent extends ViewOrderEvent {
  String id;
  String userID;

  CancelOrderEvent(this.id, this.userID);
}

class GetOrderEvent extends ViewOrderEvent {
  String id;

  GetOrderEvent(this.id);
}

class OrderCompletedEvent extends ViewOrderEvent {
  String id;
  String userID;

  OrderCompletedEvent(this.id, this.userID);
}
