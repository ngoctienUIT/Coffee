abstract class AddRecommendState {}

class InitState extends AddRecommendState {}

class AddRecommendLoading extends AddRecommendState {}

class AddRecommendSuccess extends AddRecommendState {}

class AddRecommendError extends AddRecommendState {
  String status;

  AddRecommendError(this.status);
}

class SaveButtonState extends AddRecommendState {
  bool isContinue;

  SaveButtonState(this.isContinue);
}

class ChangeTagState extends AddRecommendState {}

class ChangeWeatherState extends AddRecommendState {}
