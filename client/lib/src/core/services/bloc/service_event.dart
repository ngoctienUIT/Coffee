import '../../../data/models/order.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/user.dart';

abstract class ServiceEvent {}

class SetDataEvent extends ServiceEvent {
  PreferencesModel preferencesModel;

  SetDataEvent(this.preferencesModel);
}

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
