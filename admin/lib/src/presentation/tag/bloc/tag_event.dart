abstract class TagEvent {}

class FetchData extends TagEvent {}

class UpdateData extends TagEvent {}

class DeleteEvent extends TagEvent {
  String id;

  DeleteEvent(this.id);
}

class PickEvent extends TagEvent {}
