import '../../data/remote/response/topping/topping_response.dart';

class Topping {
  String? toppingId;
  String toppingName;
  String description;
  String? imageUrl;
  int pricePerService;
  bool isCheck;

  Topping({
    this.toppingId,
    required this.toppingName,
    required this.description,
    this.imageUrl,
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

  Map<String, dynamic> toJson() {
    return {
      "name": toppingName,
      "description": description,
      "imageUrl": imageUrl,
      "pricePerService": pricePerService,
    };
  }
}
