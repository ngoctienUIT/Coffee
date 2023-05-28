abstract class StoreEvent {}

class FetchData extends StoreEvent {}

class UpdateData extends StoreEvent {
  String query;

  UpdateData(this.query);
}

class DeleteEvent extends StoreEvent {
  String id;

  DeleteEvent(this.id);
}

class SearchStore extends StoreEvent {
  String storeName;

  SearchStore({required this.storeName});
}
