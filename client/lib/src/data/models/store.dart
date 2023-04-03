class Store {
  String? storeId;
  String? storeName;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  String? openingHour;
  String? closingHour;
  double? latitude;
  double? longitude;
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

  // factory Store.fromStoreResponse
}
