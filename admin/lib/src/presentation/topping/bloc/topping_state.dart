import 'package:equatable/equatable.dart';

import '../../../data/remote/response/topping/topping_response.dart';

abstract class ToppingState extends Equatable {}

class InitState extends ToppingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteSuccess extends ToppingState {
  final String id;

  DeleteSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class ToppingLoading extends ToppingState {
  final bool check;

  ToppingLoading([this.check = true]);

  @override
  List<Object?> get props => [check];
}

class PickState extends ToppingState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ToppingLoaded extends ToppingState {
  final List<ToppingResponse> listTopping;

  ToppingLoaded(this.listTopping);

  @override
  List<Object?> get props => [listTopping];
}

class ToppingError extends ToppingState {
  final String? message;

  ToppingError(this.message);

  @override
  List<Object?> get props => [message];
}
