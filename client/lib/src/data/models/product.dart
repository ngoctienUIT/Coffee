import 'package:coffee/src/data/models/topping.dart';
import 'package:coffee/src/domain/repositories/product/product_response.dart';

import 'tag.dart';

class Product {
  final String id;
  final String name;
  final String currency;
  final String? image;
  final String? description;
  final List<Topping>? toppingOptions;
  final List<Tag>? tags;
  final int price;
  final int S;
  final int M;
  final int L;
  final int sizeIndex;
  final int number;

  Product({
    required this.id,
    required this.name,
    required this.currency,
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
  });

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
    );
  }

  int getPrice() {
    return price + (sizeIndex == 0 ? S : (sizeIndex == 1 ? M : L));
  }

  String getPriceString() {
    return "${getPrice()}$currency";
  }

  String getTotalString() {
    return "${getPrice() * number}$currency";
  }
}
