abstract class AddToppingState {}

class InitState extends AddToppingState {}

class SaveButtonState extends AddToppingState {
  bool isContinue;

  SaveButtonState(this.isContinue);
}

class ChangeImageState extends AddToppingState {}

class AddToppingLoadingState extends AddToppingState {}

class AddToppingSuccessState extends AddToppingState {}

class AddToppingErrorState extends AddToppingState {
  String status;

  AddToppingErrorState(this.status);
}
