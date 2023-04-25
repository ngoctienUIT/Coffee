abstract class ViewOrderEvent {}

class CancelOrderEvent extends ViewOrderEvent {
  String id;

  CancelOrderEvent(this.id);
}

class GetOrderEvent extends ViewOrderEvent {
  String id;

  GetOrderEvent(this.id);
}
