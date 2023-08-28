import '../../../data/models/address.dart';

class ChangeMethodRequest {
  bool isBringBack;
  Address? address;
  String? storeID;

  ChangeMethodRequest({required this.isBringBack, this.address, this.storeID});
}
