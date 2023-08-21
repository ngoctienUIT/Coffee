import '../../../data/models/order.dart';
import '../../../data/models/user.dart';

abstract class ServiceEvent {}

class SetDataEvent extends ServiceEvent {}

class ChangeUserInfoEvent extends ServiceEvent {
  User user;

  ChangeUserInfoEvent(this.user);
}

class ChangeOrderEvent extends ServiceEvent {
  Order? order;

  ChangeOrderEvent([this.order]);
}

class ChangeStoreEvent extends ServiceEvent {}

class PlacedOrderEvent extends ServiceEvent {}

class CancelServiceOrderEvent extends ServiceEvent {
  String id;

  CancelServiceOrderEvent(this.id);
}

class CheckLoginEvent extends ServiceEvent {}

class StopTimeEvent extends ServiceEvent {}

class SaveTimeEvent extends ServiceEvent {
  Duration duration;

  SaveTimeEvent(this.duration);
}
