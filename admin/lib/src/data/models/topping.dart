import '../../domain/repositories/topping/topping_response.dart';

class Topping {
  final String toppingId;
  final String toppingName;
  final String description;
  final String imageUrl;
  final int pricePerService;
  final bool isCheck;

  Topping({
    required this.toppingId,
    required this.toppingName,
    required this.description,
    required this.imageUrl,
    required this.pricePerService,
    this.isCheck = false,
  });

  factory Topping.fromToppingResponse(ToppingResponse topping) {
    return Topping(
      toppingId: topping.toppingId,
      toppingName: topping.toppingName,
      description: topping.description,
      imageUrl: topping.imageUrl,
      pricePerService: topping.pricePerService,
    );
  }
}
