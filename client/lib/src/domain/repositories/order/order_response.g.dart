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
      status: json['status'] as String?,
      orderItems: (json['orderItems'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
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
      orderAmount: json['orderAmount'] as String?,
      appliedCoupons: (json['appliedCoupons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orderStatus: json['orderStatus'] as String?,
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'userId': instance.userId,
      'createdDate': instance.createdDate,
      'lastUpdated': instance.lastUpdated,
      'status': instance.status,
      'orderItems': instance.orderItems,
      'selectedPaymentMethod': instance.selectedPaymentMethod,
      'selectedPickupOption': instance.selectedPickupOption,
      'selectedPickupStore': instance.selectedPickupStore,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'address4': instance.address4,
      'orderAmount': instance.orderAmount,
      'appliedCoupons': instance.appliedCoupons,
      'orderStatus': instance.orderStatus,
    };
