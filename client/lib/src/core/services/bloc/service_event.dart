import 'package:equatable/equatable.dart';

import '../../../data/models/order.dart';
import '../../../data/models/user.dart';

abstract class ServiceEvent extends Equatable {}

class ChangeUserInfoEvent extends ServiceEvent {
  final User user;

  ChangeUserInfoEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class ChangeOrderEvent extends ServiceEvent {
  final Order? order;

  ChangeOrderEvent([this.order]);

  @override
  List<Object?> get props => [order];
}

class ChangeStoreEvent extends ServiceEvent {
  @override
  List<Object?> get props => [];
}

class PlacedOrderEvent extends ServiceEvent {
  @override
  List<Object?> get props => [];
}

class CancelServiceOrderEvent extends ServiceEvent {
  final String id;

  CancelServiceOrderEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CheckLoginEvent extends ServiceEvent {
  @override
  List<Object?> get props => [];
}

class StopTimeEvent extends ServiceEvent {
  @override
  List<Object?> get props => [];
}

class SaveTimeEvent extends ServiceEvent {
  final Duration duration;

  SaveTimeEvent(this.duration);

  @override
  List<Object?> get props => [duration];
}
