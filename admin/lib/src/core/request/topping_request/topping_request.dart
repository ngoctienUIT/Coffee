import 'package:coffee_admin/src/data/models/topping.dart';

class ToppingRequest {
  final Topping topping;
  final String image;

  ToppingRequest({required this.topping, required this.image});
}
