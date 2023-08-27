import 'package:equatable/equatable.dart';

import '../../../data/models/order.dart';
import '../../../data/models/user.dart';

abstract class ServiceEvent extends Equatable {}

// class SetDataEvent extends ServiceEvent {
//   PreferencesModel preferencesModel;
//
//   SetDataEvent(this.preferencesModel);
// }

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
  List<Object?> get props => [identityHashCode(this)];
}

class PlacedOrderEvent extends ServiceEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CheckLoginEvent extends ServiceEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class StopTimeEvent extends ServiceEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SaveTimeEvent extends ServiceEvent {
  final Duration duration;

  SaveTimeEvent(this.duration);

  @override
  List<Object?> get props => [identityHashCode(this)];
}
