abstract class OrderEvent {}

class FetchData extends OrderEvent {}

class RefreshData extends OrderEvent {
  int index = 0;

  RefreshData(this.index);
}

class AddProductToCart extends OrderEvent {
  bool isChange;

  AddProductToCart([this.isChange = false]);
}
