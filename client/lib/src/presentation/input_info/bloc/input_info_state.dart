abstract class InputInfoState {}

class InitState extends InputInfoState {}

class SubmitLoadingState extends InputInfoState {}

class SubmitSuccessState extends InputInfoState {}

class SubmitErrorState extends InputInfoState {
  String status;
  SubmitErrorState({required this.status});
}

class ContinueState extends InputInfoState {
  bool isContinue;

  ContinueState({required this.isContinue});
}

class HidePasswordState extends InputInfoState {
  bool isHide;

  HidePasswordState({required this.isHide});
}

class TextChangeState extends InputInfoState {}

class ChangeBirthdayState extends InputInfoState {}

class ChangeGenderState extends InputInfoState {}
