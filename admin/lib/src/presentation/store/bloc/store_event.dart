abstract class StoreEvent {}

class FetchData extends StoreEvent {}

class UpdateData extends StoreEvent {}

class DeleteEvent extends StoreEvent {
  String id;
  String query;

  DeleteEvent(this.id, this.query);
}

class SearchStore extends StoreEvent {
  String storeName;

  SearchStore({required this.storeName});
}
