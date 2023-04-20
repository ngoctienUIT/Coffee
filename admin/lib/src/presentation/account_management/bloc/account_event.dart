abstract class AccountEvent {}

class FetchData extends AccountEvent {}

class UpdateData extends AccountEvent {
  int index = 0;

  UpdateData(this.index);
}

class DeleteEvent extends AccountEvent {
  String id;
  int index = 0;

  DeleteEvent(this.id, this.index);
}

class RefreshData extends AccountEvent {
  int index = 0;

  RefreshData(this.index);
}
