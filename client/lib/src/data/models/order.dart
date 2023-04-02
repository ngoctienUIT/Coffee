import 'package:coffee/src/domain/repositories/order/order_response.dart';

import 'item_order.dart';

class Order {
  String? orderId;
  String userId;
  String? createdDate;
  String? lastUpdated;
  String? status;
  List<ItemOrder> orderItems;
  String? selectedPaymentMethod;
  String? selectedPickupOption;
  String? storeId;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  int? orderAmount;
  String? appliedCoupons;
  String? orderStatus;

  Order({
    this.orderId,
    required this.userId,
    this.createdDate,
    this.lastUpdated,
    this.status,
    required this.orderItems,
    this.selectedPaymentMethod,
    this.selectedPickupOption,
    this.storeId,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.orderAmount,
    this.appliedCoupons,
    this.orderStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "orderItems": orderItems.map((e) => e.toJson()).toList(),
      "paymentMethod": "CASH",
      "pickupOptions": "AT_STORE",
      "couponId": null,
      "storeId": storeId,
    };
  }

  factory Order.fromOrderResponse(OrderResponse orderResponse) {
    return Order(
      userId: orderResponse.userId!,
      orderId: orderResponse.orderId,
      orderItems: orderResponse.orderItems == null
          ? []
          : orderResponse.orderItems!
              .map((e) => ItemOrder.fromItemOrderResponse(e))
              .toList(),
      status: orderResponse.status,
      address1: orderResponse.address1,
      address2: orderResponse.address2,
      address3: orderResponse.address3,
      address4: orderResponse.address4,
      appliedCoupons: null,
      createdDate: orderResponse.createdDate,
      lastUpdated: orderResponse.lastUpdated,
      orderAmount: orderResponse.orderAmount,
      orderStatus: orderResponse.orderStatus,
      selectedPaymentMethod: orderResponse.selectedPaymentMethod,
      selectedPickupOption: orderResponse.selectedPickupOption,
      storeId: orderResponse.selectedPickupStore!.storeId,
    );
  }
}
