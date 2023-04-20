abstract class SettingState {}

class InitState extends SettingState {}

class DeleteLoadingState extends SettingState {}

class DeleteSuccessState extends SettingState {}

class DeleteErrorState extends SettingState {
  String error;

  DeleteErrorState(this.error);
}
