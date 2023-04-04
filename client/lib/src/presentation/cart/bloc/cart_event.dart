import '../../../data/models/address.dart';

abstract class CartEvent {}

class GetOrderSpending extends CartEvent {}

class DeleteOrderEvent extends CartEvent {}

class DeleteProductEvent extends CartEvent {
  String id;

  DeleteProductEvent(this.id);
}

class AttachCouponToOrder extends CartEvent {
  String id;

  AttachCouponToOrder(this.id);
}

class ChangeMethod extends CartEvent {
  bool isBringBack;
  Address? address;
  String? storeID;

  ChangeMethod({required this.isBringBack, this.address, this.storeID});
}

class PlaceOrder extends CartEvent {}

class AddNote extends CartEvent {
  String note;

  AddNote(this.note);
}
