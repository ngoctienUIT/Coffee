import '../../../data/remote/response/topping/topping_response.dart';

abstract class ToppingState {}

class InitState extends ToppingState {}

class DeleteSuccess extends ToppingState {
  String id;

  DeleteSuccess(this.id);
}

class ToppingLoading extends ToppingState {
  bool check;

  ToppingLoading([this.check = true]);
}

class PickState extends ToppingState {}

class ToppingLoaded extends ToppingState {
  final List<ToppingResponse> listTopping;

  ToppingLoaded(this.listTopping);
}

class ToppingError extends ToppingState {
  final String? message;
  ToppingError(this.message);
}
