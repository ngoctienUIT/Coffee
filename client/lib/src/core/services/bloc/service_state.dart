abstract class ServiceState {}

class InitServiceState extends ServiceState {}

class ChangeUserInfoState extends ServiceState {}

class ChangeOrderState extends ServiceState {}

class ChangeStoreState extends ServiceState {}

class PlacedOrderState extends ServiceState {}

class CancelServiceOrderState extends ServiceState {
  String id;

  CancelServiceOrderState(this.id);
}

class LogOutState extends ServiceState {}
