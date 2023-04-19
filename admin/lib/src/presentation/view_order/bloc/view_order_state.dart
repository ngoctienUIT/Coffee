abstract class ViewOrderState {}

class InitState extends ViewOrderState {}

class LoadingState extends ViewOrderState {}

class CancelSuccessState extends ViewOrderState {}

class CompletedSuccessState extends ViewOrderState {}

class ErrorState extends ViewOrderState {
  String error;

  ErrorState(this.error);
}
