import 'package:json_annotation/json_annotation.dart';

part 'coupon_response.g.dart';

@JsonSerializable()
class CouponResponse {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "couponName")
  final String couponName;

  @JsonKey(name: "couponCode")
  final String couponCode;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "imageUrl")
  final String imageUrl;

  @JsonKey(name: "dueDate")
  final String dueDate;

  CouponResponse({
    required this.id,
    required this.couponName,
    required this.couponCode,
    required this.content,
    required this.imageUrl,
    required this.dueDate,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponResponseToJson(this);
}
