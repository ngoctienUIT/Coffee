import 'package:equatable/equatable.dart';

import '../../data/remote/response/order/order_response.dart';
import 'address.dart';
import 'coupon.dart';
import 'item_order.dart';
import 'store.dart';

//ignore: must_be_immutable
class Order extends Equatable {
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
  String? orderNote;
  Store? selectedPickupStore;
  Coupon? appliedCoupon;

  Order({
    this.orderId,
    required this.userId,
    this.createdDate,
    this.lastUpdated,
    this.status,
    required this.orderItems,
    this.orderNote,
    this.selectedPaymentMethod,
    this.selectedPickupOption,
    this.selectedPickupStore,
    this.storeId,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.orderAmount,
    this.appliedCoupons,
    this.appliedCoupon,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "userId": userId,
      "orderItems": orderItems.map((e) => e.toJson()).toList(),
      "paymentMethod": "CASH",
      "pickupOptions": selectedPickupOption,
      "couponId": appliedCoupons ?? "",
      "storeId": storeId,
      "address1": address1,
      "address2": address2,
      "address3": address3,
      "address4": address4,
      "orderNote": orderNote,
    };
  }

  void addAddress(Address address) {
    address4 = address.province;
    address3 = address.district;
    address2 = address.ward;
    address1 = address.address;
  }

  void removeAddress() {
    address1 = null;
    address2 = null;
    address3 = null;
    address4 = null;
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
      status: orderResponse.orderStatus,
      address1: orderResponse.address1,
      address2: orderResponse.address2,
      address3: orderResponse.address3,
      address4: orderResponse.address4,
      appliedCoupons: orderResponse.appliedCoupon?.id,
      appliedCoupon: orderResponse.appliedCoupon == null
          ? null
          : Coupon.fromCouponResponse(orderResponse.appliedCoupon!),
      createdDate: orderResponse.createdDate,
      lastUpdated: orderResponse.lastUpdated,
      orderAmount: orderResponse.orderAmount,
      selectedPaymentMethod: orderResponse.selectedPaymentMethod,
      selectedPickupOption: orderResponse.selectedPickupOption,
      storeId: orderResponse.selectedPickupStore?.storeId,
      selectedPickupStore: orderResponse.selectedPickupStore == null
          ? null
          : Store.fromStoreResponse(orderResponse.selectedPickupStore!),
      orderNote: orderResponse.orderCustomerNote,
    );
  }

  Order copyWith({
    List<ItemOrder>? orderItems,
    String? selectedPaymentMethod,
    String? selectedPickupOption,
    String? storeId,
    String? address1,
    String? address2,
    String? address3,
    String? address4,
    int? orderAmount,
    String? appliedCoupons,
    String? orderNote,
    Store? selectedPickupStore,
    Coupon? appliedCoupon,
  }) {
    return Order(
      userId: userId,
      orderId: orderId,
      orderItems: orderItems ?? this.orderItems,
      status: status,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      address4: address4 ?? this.address4,
      appliedCoupons: appliedCoupons ?? this.appliedCoupons,
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
      createdDate: createdDate,
      lastUpdated: lastUpdated,
      orderAmount: orderAmount ?? this.orderAmount,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      selectedPickupOption: selectedPickupOption ?? this.selectedPickupOption,
      storeId: storeId ?? this.storeId,
      selectedPickupStore: selectedPickupStore ?? this.selectedPickupStore,
      orderNote: orderNote ?? this.orderNote,
    );
  }

  int getTotal() {
    int total = 0;
    for (var item in orderItems) {
      total += item.getTotal();
    }
    return total;
  }

  String getAddress() => "$address1, $address2, $address3, $address4";

  @override
  List<Object?> get props => [
        orderId,
        orderItems,
        orderNote,
        status,
        selectedPickupOption,
        selectedPickupStore,
        storeId,
        address1,
        address2,
        address3,
        address4,
        orderAmount,
        appliedCoupons,
        appliedCoupon,
      ];
}
