import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {}

class FetchData extends StoreEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class RefreshData extends StoreEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SearchStore extends StoreEvent {
  final String storeName;

  SearchStore({required this.storeName});

  @override
  List<Object?> get props => [storeName];
}
