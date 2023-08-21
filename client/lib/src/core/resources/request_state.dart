class RequestState<T> {
  final String? error;
  final T state;

  RequestState(this.state, [this.error]);
}
