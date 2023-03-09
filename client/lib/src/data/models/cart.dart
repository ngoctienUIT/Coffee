import 'package:coffee/src/data/models/product.dart';

class Cart {
  DateTime time;
  List<Product> listProduct;
  bool isBringBack;
  String? note;
  bool isPaymentMomo;

  Cart({
    required this.time,
    required this.listProduct,
    this.isBringBack = true,
    this.isPaymentMomo = true,
    this.note,
  });
}
