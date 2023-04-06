abstract class AddTagState {}

class InitState extends AddTagState {}

class SaveButtonState extends AddTagState {
  bool isContinue;

  SaveButtonState(this.isContinue);
}

class AddTagLoadingState extends AddTagState {}

class AddTagSuccessState extends AddTagState {}

class AddTagErrorState extends AddTagState {
  String status;

  AddTagErrorState(this.status);
}
