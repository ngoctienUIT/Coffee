import '../../../data/models/preferences_model.dart';

abstract class ServiceEvent {}

class SetDataEvent extends ServiceEvent {
  PreferencesModel preferencesModel;

  SetDataEvent(this.preferencesModel);
}

class ChangeUserEvent extends ServiceEvent {
  PreferencesModel preferencesModel;

  ChangeUserEvent(this.preferencesModel);
}
