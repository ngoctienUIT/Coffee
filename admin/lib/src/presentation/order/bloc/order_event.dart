abstract class OrderEvent {}

class FetchData extends OrderEvent {}

class UpdateData extends OrderEvent {
  int index = 0;

  UpdateData(this.index);
}

class RefreshData extends OrderEvent {
  int index = 0;

  RefreshData(this.index);
}

class ChangeOrderListEvent extends OrderEvent {
  String id;

  ChangeOrderListEvent(this.id);
}
