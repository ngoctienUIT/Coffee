abstract class AddStoreState {}

class InitState extends AddStoreState {}

class ChangeImageState extends AddStoreState {}

class ChangeAddressState extends AddStoreState {}

class ChangeOpenState extends AddStoreState {}

class ChangeCloseState extends AddStoreState {}

class SaveButtonState extends AddStoreState {
  bool isContinue;

  SaveButtonState(this.isContinue);
}

class AddStoreLoadingState extends AddStoreState {}

class AddStoreSuccessState extends AddStoreState {}

class AddStoreErrorState extends AddStoreState {
  String status;

  AddStoreErrorState(this.status);
}
