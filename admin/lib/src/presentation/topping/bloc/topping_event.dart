abstract class ToppingEvent {}

class FetchData extends ToppingEvent {}

class PickEvent extends ToppingEvent {}

class DeleteEvent extends ToppingEvent {
  String id;

  DeleteEvent(this.id);
}
