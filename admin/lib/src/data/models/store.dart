import '../../data/remote/response/store/store_response.dart';

class Store {
  String? storeId;
  String? storeName;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  String? openingHour;
  String? closingHour;
  String? latitude;
  String? longitude;
  String? imageUrl;
  String? hotlineNumber;
  String? googleMapUrl;
  String? registrationDate;
  String? lastUpdateDate;

  Store({
    this.storeId,
    this.storeName,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.openingHour,
    this.closingHour,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.hotlineNumber,
    this.googleMapUrl,
    this.registrationDate,
    this.lastUpdateDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": storeName,
      "hotlineNumber": hotlineNumber,
      "imageUrl": imageUrl,
      "address1": address1,
      "address2": address2,
      "address3": address3,
      "address4": address4,
      "openingHour": openingHour,
      "closingHour": closingHour,
    };
  }

  factory Store.fromStoreResponse(StoreResponse storeResponse) {
    return Store(
      storeId: storeResponse.storeId,
      storeName: storeResponse.storeName,
      address1: storeResponse.address1,
      address2: storeResponse.address2,
      address3: storeResponse.address3,
      address4: storeResponse.address4,
      openingHour: storeResponse.openingHour,
      closingHour: storeResponse.closingHour,
      latitude: storeResponse.latitude,
      longitude: storeResponse.longitude,
      imageUrl: storeResponse.imageUrl,
      hotlineNumber: storeResponse.hotlineNumber,
      googleMapUrl: storeResponse.googleMapUrl,
      registrationDate: storeResponse.registrationDate,
      lastUpdateDate: storeResponse.lastUpdateDate,
    );
  }
}
