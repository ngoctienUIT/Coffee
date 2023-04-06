abstract class AddProductCataloguesState {}

class InitState extends AddProductCataloguesState {}

class SaveButtonState extends AddProductCataloguesState {
  bool isContinue;

  SaveButtonState(this.isContinue);
}

class ChangeImageState extends AddProductCataloguesState {}

class AddProductCataloguesLoadingState extends AddProductCataloguesState {}

class AddProductCataloguesSuccessState extends AddProductCataloguesState {}

class AddProductCataloguesErrorState extends AddProductCataloguesState {
  String status;

  AddProductCataloguesErrorState(this.status);
}
