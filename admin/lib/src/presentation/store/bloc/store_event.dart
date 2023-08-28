import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {}

class FetchData extends StoreEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends StoreEvent {
  final String query;

  UpdateData(this.query);

  @override
  List<Object?> get props => [query];
}

class DeleteEvent extends StoreEvent {
  final String id;

  DeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchStore extends StoreEvent {
  final String storeName;

  SearchStore({required this.storeName});

  @override
  List<Object?> get props => [storeName];
}
