import 'package:equatable/equatable.dart';

abstract class ViewOrderEvent extends Equatable {}

class CancelOrderEvent extends ViewOrderEvent {
  final String id;

  CancelOrderEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetOrderEvent extends ViewOrderEvent {
  final String id;

  GetOrderEvent(this.id);

  @override
  List<Object?> get props => [id];
}
