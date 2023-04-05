abstract class AccountEvent {}

class FetchData extends AccountEvent {}

class RefreshData extends AccountEvent {
  int index = 0;

  RefreshData(this.index);
}
