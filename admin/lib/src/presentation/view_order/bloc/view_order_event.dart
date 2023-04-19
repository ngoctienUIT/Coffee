abstract class ViewOrderEvent {}

class CancelOrderEvent extends ViewOrderEvent {
  String id;
  String userID;

  CancelOrderEvent(this.id, this.userID);
}

class OrderCompletedEvent extends ViewOrderEvent {
  String id;
  String userID;

  OrderCompletedEvent(this.id, this.userID);
}
