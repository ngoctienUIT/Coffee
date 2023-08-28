import 'package:equatable/equatable.dart';

abstract class ViewOrderEvent extends Equatable {}

class CancelOrderEvent extends ViewOrderEvent {
  final String id;
  final String userID;

  CancelOrderEvent(this.id, this.userID);

  @override
  List<Object?> get props => [id, userID];
}

class GetOrderEvent extends ViewOrderEvent {
  final String id;

  GetOrderEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class OrderCompletedEvent extends ViewOrderEvent {
  final String id;
  final String userID;

  OrderCompletedEvent(this.id, this.userID);

  @override
  List<Object?> get props => [id, userID];
}
