abstract class AddProductState {}

class InitState extends AddProductState {}

class ChangeImageState extends AddProductState {}

class ChangeCatalogueState extends AddProductState {}

class SaveButtonState extends AddProductState {
  bool isContinue;

  SaveButtonState(this.isContinue);
}

class AddProductLoadingState extends AddProductState {}

class AddProductSuccessState extends AddProductState {}

class AddProductErrorState extends AddProductState {
  String status;

  AddProductErrorState(this.status);
}
