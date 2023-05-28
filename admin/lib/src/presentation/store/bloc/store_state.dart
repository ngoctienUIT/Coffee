import '../../../domain/repositories/store/store_response.dart';

abstract class StoreState {}

class InitState extends StoreState {}

class DeleteSuccess extends StoreState {
  String id;

  DeleteSuccess(this.id);
}

class StoreLoading extends StoreState {
  bool check;

  StoreLoading([this.check = true]);
}

class StoreLoaded extends StoreState {
  final List<StoreResponse> listStore;

  StoreLoaded(this.listStore);
}

class StoreError extends StoreState {
  final String? message;

  StoreError(this.message);
}
