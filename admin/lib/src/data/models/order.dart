import '../../data/remote/response/order/order_response.dart';
import 'address.dart';
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
  String? orderNote;

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
    if (selectedPickupOption == "AT_STORE") {
      return {
        "userId": userId,
        "orderItems": orderItems.map((e) => e.toJson()).toList(),
        "paymentMethod": "CASH",
        "pickupOptions": selectedPickupOption,
        "couponId": null,
        "storeId": storeId,
        "orderNote": orderNote,
      };
    } else {
      return {
        "userId": userId,
        "orderItems": orderItems.map((e) => e.toJson()).toList(),
        "paymentMethod": "CASH",
        "pickupOptions": selectedPickupOption,
        "couponId": null,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "address4": address4,
        "orderNote": orderNote,
      };
    }
  }

  void addAddress(Address address) {
    address1 = address.province;
    address2 = address.district;
    address3 = address.ward;
    address4 = address.address;
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
      appliedCoupons: null,
      createdDate: orderResponse.createdDate,
      lastUpdated: orderResponse.lastUpdated,
      orderAmount: orderResponse.orderAmount,
      orderStatus: orderResponse.orderStatus,
      selectedPaymentMethod: orderResponse.selectedPaymentMethod,
      selectedPickupOption: orderResponse.selectedPickupOption,
      storeId: orderResponse.selectedPickupStore!.storeId,
      orderNote: orderResponse.orderCustomerNote,
    );
  }
}
