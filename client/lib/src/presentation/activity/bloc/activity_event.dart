abstract class ActivityEvent {}

class FetchData extends ActivityEvent {
  final int index;

  FetchData(this.index);
}
