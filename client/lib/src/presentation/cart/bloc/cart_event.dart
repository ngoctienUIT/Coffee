import 'package:equatable/equatable.dart';

import '../../../data/models/address.dart';

abstract class CartEvent extends Equatable {}

class GetOrderSpending extends CartEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteOrderEvent extends CartEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteProductEvent extends CartEvent {
  final int index;

  DeleteProductEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class AttachCouponToOrder extends CartEvent {
  final String id;

  AttachCouponToOrder(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteCouponOrder extends CartEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ChangeMethod extends CartEvent {
  final bool isBringBack;
  final Address? address;
  final String? storeID;

  ChangeMethod({required this.isBringBack, this.address, this.storeID});

  @override
  List<Object?> get props => [isBringBack, address, storeID];
}

class PlaceOrder extends CartEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddNote extends CartEvent {
  final String note;

  AddNote(this.note);

  @override
  List<Object?> get props => [note];
}
