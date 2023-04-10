import '../../../domain/repositories/topping/topping_response.dart';

abstract class ToppingState {}

class InitState extends ToppingState {}

class ToppingLoading extends ToppingState {}

class PickState extends ToppingState {}

class ToppingLoaded extends ToppingState {
  final List<ToppingResponse> listTopping;

  ToppingLoaded(this.listTopping);
}

class ToppingError extends ToppingState {
  final String? message;
  ToppingError(this.message);
}
