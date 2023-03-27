import 'package:coffee/src/domain/repositories/store/store_response.dart';

abstract class StoreState {}

class InitState extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreResponse> listStore;
  StoreLoaded(this.listStore);
}

class StoreError extends StoreState {
  final String? message;
  StoreError(this.message);
}
