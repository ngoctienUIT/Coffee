import 'package:json_annotation/json_annotation.dart';

part 'topping_response.g.dart';

@JsonSerializable()
class ToppingResponse {
  @JsonKey(name: "toppingId")
  final String toppingId;

  @JsonKey(name: "toppingName")
  final String toppingName;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "imageUrl")
  final String imageUrl;

  @JsonKey(name: "pricePerService")
  final int pricePerService;

  ToppingResponse({
    required this.toppingId,
    required this.toppingName,
    required this.description,
    required this.imageUrl,
    required this.pricePerService,
  });

  factory ToppingResponse.fromJson(Map<String, dynamic> json) =>
      _$ToppingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingResponseToJson(this);
}
