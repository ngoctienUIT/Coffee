abstract class ActivityEvent {}

class FetchData extends ActivityEvent {
  final int index;

  FetchData(this.index);
}

class UpdateData extends ActivityEvent {
  int index;

  UpdateData(this.index);
}
