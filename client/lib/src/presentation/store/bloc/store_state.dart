import 'package:coffee/src/data/models/store.dart';

abstract class StoreState {}

class InitState extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<Store> listStore;
  String id;

  StoreLoaded(this.listStore, this.id);
}

class StoreError extends StoreState {
  final String? message;
  StoreError(this.message);
}
