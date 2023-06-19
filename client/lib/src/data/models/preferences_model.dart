import 'package:dio/dio.dart';

import '../../domain/api_service.dart';
import 'order.dart';
import 'product.dart';
import 'store.dart';
import 'user.dart';

class PreferencesModel {
  String token;
  String? storeID;
  String? address;
  bool isBringBack;
  User? user;
  Order? order;
  List<Store> listStore;
  List<Product> listProduct;
  ApiService apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));

  PreferencesModel({
    this.token = "",
    this.user,
    this.order,
    this.storeID,
    this.address,
    this.listStore = const [],
    this.listProduct = const [],
    this.isBringBack = false,
  });

  PreferencesModel copyWith({
    String? token,
    String? storeID,
    String? address,
    bool? isBringBack,
    User? user,
    Order? order,
    List<Store>? listStore,
    List<Product>? listProduct,
    bool isChangeOrder = false,
  }) {
    Order? myOrder;
    if (storeID != null && this.order != null && !isBringBack!) {
      print("Change store");
      myOrder = this.order!.copyWith(
          storeId: storeID,
          selectedPickupStore: getStore(storeID),
          selectedPickupOption: "AT_STORE");
    }
    if (address != null && this.order != null && isBringBack!) {
      print("Change address");
      List<String> list = address.split(", ");
      myOrder = this.order!.copyWith(
          address1: list[0],
          address2: list[1],
          address3: list[2],
          address4: list[3],
          selectedPickupOption: "DELIVERY");
    }
    return PreferencesModel(
      token: token ?? this.token,
      storeID: storeID ?? this.storeID,
      address: address ?? this.address,
      isBringBack: isBringBack ?? this.isBringBack,
      user: user ?? this.user,
      listProduct: listProduct ?? this.listProduct,
      order: myOrder ?? (isChangeOrder ? order : this.order),
      listStore: listStore ?? this.listStore,
    );
  }

  Store? getStore([String? id]) {
    int index =
        listStore.indexWhere((element) => element.storeId == (id ?? storeID));
    return index != -1 ? listStore.elementAt(index) : null;
  }
}
