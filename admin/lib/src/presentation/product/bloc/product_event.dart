abstract class ProductEvent {}

class FetchData extends ProductEvent {}

class RefreshData extends ProductEvent {
  int index = 0;

  RefreshData(this.index);
}
