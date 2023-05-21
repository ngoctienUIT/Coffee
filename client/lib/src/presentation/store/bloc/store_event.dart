abstract class StoreEvent {}

class FetchData extends StoreEvent {}

class SearchStore extends StoreEvent {
  String storeName;

  SearchStore({required this.storeName});
}
