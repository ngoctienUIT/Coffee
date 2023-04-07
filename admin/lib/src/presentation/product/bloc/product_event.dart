abstract class ProductEvent {}

class FetchData extends ProductEvent {}

class DeleteEvent extends ProductEvent {
  int index;
  String id;

  DeleteEvent(this.index,this.id);
}

class RefreshData extends ProductEvent {
  int index = 0;

  RefreshData(this.index);
}
