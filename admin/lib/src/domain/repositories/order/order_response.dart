import 'package:coffee_admin/src/domain/entities/item_order/item_order_entity.dart';
import 'package:coffee_admin/src/domain/repositories/coupon/coupon_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../store/store_response.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: "orderId")
  String? orderId;

  @JsonKey(name: "userId")
  String? userId;

  @JsonKey(name: "createdDate")
  String? createdDate;

  @JsonKey(name: "lastUpdated")
  String? lastUpdated;

  @JsonKey(name: "orderItems")
  List<ItemOrderEntity>? orderItems;

  @JsonKey(name: "selectedPaymentMethod")
  String? selectedPaymentMethod;

  @JsonKey(name: "selectedPickupOption")
  String? selectedPickupOption;

  @JsonKey(name: "selectedPickupStore")
  StoreResponse? selectedPickupStore;

  @JsonKey(name: "address1")
  String? address1;

  @JsonKey(name: "address2")
  String? address2;

  @JsonKey(name: "address3")
  String? address3;

  @JsonKey(name: "address4")
  String? address4;

  @JsonKey(name: "orderAmount")
  int? orderAmount;

  @JsonKey(name: "appliedCoupons")
  List<CouponResponse>? appliedCoupons;

  @JsonKey(name: "orderStatus")
  String? orderStatus;

  OrderResponse({
    this.orderId,
    this.userId,
    this.createdDate,
    this.lastUpdated,
    this.orderItems,
    this.selectedPaymentMethod,
    this.selectedPickupOption,
    this.selectedPickupStore,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.orderAmount,
    this.appliedCoupons,
    this.orderStatus,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
