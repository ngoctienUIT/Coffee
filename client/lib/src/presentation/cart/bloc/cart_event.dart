import '../../../data/models/address.dart';
import '../../../data/models/preferences_model.dart';

abstract class CartEvent {}

class GetOrderSpending extends CartEvent {}

class SetPreferencesModel extends CartEvent {
  PreferencesModel preferencesModel;

  SetPreferencesModel(this.preferencesModel);
}

class DeleteOrderEvent extends CartEvent {}

class DeleteProductEvent extends CartEvent {
  int index;

  DeleteProductEvent(this.index);
}

class AttachCouponToOrder extends CartEvent {
  String id;

  AttachCouponToOrder(this.id);
}

class DeleteCouponOrder extends CartEvent {}

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
