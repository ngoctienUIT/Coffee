// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      orderId: json['orderId'] as String?,
      userId: json['userId'] as String?,
      createdDate: json['createdDate'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => ItemOrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedPaymentMethod: json['selectedPaymentMethod'] as String?,
      selectedPickupOption: json['selectedPickupOption'] as String?,
      selectedPickupStore: json['selectedPickupStore'] == null
          ? null
          : StoreResponse.fromJson(
              json['selectedPickupStore'] as Map<String, dynamic>),
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      address4: json['address4'] as String?,
      orderAmount: json['orderAmount'] as int?,
      orderStatus: json['orderStatus'] as String?,
      orderCustomerNote: json['orderCustomerNote'] as String?,
    )..appliedCoupon = json['appliedCoupon'] == null
        ? null
        : CouponResponse.fromJson(
            json['appliedCoupon'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'userId': instance.userId,
      'createdDate': instance.createdDate,
      'lastUpdated': instance.lastUpdated,
      'orderItems': instance.orderItems,
      'selectedPaymentMethod': instance.selectedPaymentMethod,
      'selectedPickupOption': instance.selectedPickupOption,
      'selectedPickupStore': instance.selectedPickupStore,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'address4': instance.address4,
      'orderAmount': instance.orderAmount,
      'appliedCoupon': instance.appliedCoupon,
      'orderStatus': instance.orderStatus,
      'orderCustomerNote': instance.orderCustomerNote,
    };
