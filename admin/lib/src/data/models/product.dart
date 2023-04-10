import '../../domain/repositories/product/product_response.dart';
import 'item_order.dart';
import 'tag.dart';
import 'topping.dart';

class Product {
  final String? id;
  String name;
  final String currency;
  String? image;
  String? description;
  List<Topping>? toppingOptions;
  List<bool>? chooseTopping;
  List<Tag>? tags;
  int price;
  int S;
  int M;
  int L;
  int sizeIndex;
  int number;

  Product({
    this.id,
    required this.name,
    this.currency = "đ",
    this.image,
    this.description,
    this.toppingOptions,
    this.tags,
    required this.price,
    this.S = 0,
    required this.M,
    required this.L,
    this.sizeIndex = 0,
    this.number = 1,
    this.chooseTopping,
  }) {
    if (toppingOptions != null) {
      chooseTopping = List.filled(toppingOptions!.length, false);
    }
  }

  factory Product.fromProductResponse(ProductResponse product) {
    return Product(
      id: product.id,
      name: product.name,
      image: product.image,
      description: product.description,
      toppingOptions: product.toppingOptions
          .map((e) => Topping.fromToppingResponse(e))
          .toList(),
      tags: product.tags.map((e) => Tag.fromTagResponse(e)).toList(),
      currency: product.currency,
      price: product.price,
      S: product.upsizeOptions.s ?? 0,
      M: product.upsizeOptions.m,
      L: product.upsizeOptions.l,
    );
  }

  Product copyWith({
    List<Topping>? toppingOptions,
    int? sizeIndex,
    int? number,
    List<bool>? chooseTopping,
  }) {
    return Product(
      id: id,
      name: name,
      image: image,
      description: description,
      currency: currency,
      price: price,
      S: S,
      M: M,
      L: L,
      tags: tags,
      toppingOptions: toppingOptions ?? this.toppingOptions,
      sizeIndex: sizeIndex ?? this.sizeIndex,
      number: number ?? this.number,
      chooseTopping: chooseTopping ?? this.chooseTopping,
    );
  }

  int getPrice() => price + (sizeIndex == 0 ? S : (sizeIndex == 1 ? M : L));

  String getPriceString() => "${getPrice()}$currency";

  int getTotal() {
    int toppingPrice = 0;
    for (int i = 0; i < chooseTopping!.length; i++) {
      if (chooseTopping![i]) toppingPrice += toppingOptions![i].pricePerService;
    }
    return (getPrice() + toppingPrice) * number;
  }

  String getTotalString() => "${getPrice() * number}$currency";

  String getSize() => sizeIndex == 0 ? "S" : (sizeIndex == 1 ? "M" : "L");

  bool isTopping() => chooseTopping!.contains(true);

  int totalTopping() =>
      chooseTopping!.where((element) => element).toList().length;

  ItemOrder toItemOrder() {
    List<String> list = toppingOptions!
        .where((element) => chooseTopping![toppingOptions!.indexOf(element)])
        .map((e) => e.toppingId!)
        .toList();
    return ItemOrder(
      productId: id!,
      quantity: number,
      toppingIds: toppingOptions == null ? [] : list,
      selectedSize: sizeIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      // 'currency': currency,
      'imageUrl': image,
      'description': description,
      'toppingIds': toppingOptions!.map((e) => e.toppingId).toList(),
      // 'tags': tags,
      'upsizeOptions': {"S": S, "M": M, "L": L},
    };
  }
}
