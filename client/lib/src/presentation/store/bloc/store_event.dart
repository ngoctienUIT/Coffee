import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {}

class FetchData extends StoreEvent {
  @override
  List<Object?> get props => [];
}

class RefreshData extends StoreEvent {
  @override
  List<Object?> get props => [];
}

class SearchStore extends StoreEvent {
  final String storeName;

  SearchStore({required this.storeName});

  @override
  List<Object?> get props => [storeName];
}
