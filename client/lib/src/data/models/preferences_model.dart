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
  }) {
    return PreferencesModel(
      token: token ?? this.token,
      storeID: storeID ?? this.storeID,
      address: address ?? this.address,
      isBringBack: isBringBack ?? this.isBringBack,
      user: user ?? this.user,
      listProduct: listProduct ?? this.listProduct,
      order: order ?? this.order,
      listStore: listStore ?? this.listStore,
    );
  }

  Store? getStore() {
    int index = listStore.indexWhere((element) => element.storeId == storeID);
    return index != -1 ? listStore.elementAt(index) : null;
  }
}
