import 'package:floor/floor.dart';

import '../../models/store.dart';

@Entity(tableName: "Store")
class StoreEntity {
  @primaryKey
  final String storeId;

  @ColumnInfo(name: "storeName")
  final String? storeName;

  @ColumnInfo(name: "address1")
  final String? address1;

  @ColumnInfo(name: "address2")
  final String? address2;

  @ColumnInfo(name: "address3")
  final String? address3;

  @ColumnInfo(name: "address4")
  final String? address4;

  @ColumnInfo(name: "openingHour")
  final String openingHour;

  @ColumnInfo(name: "closingHour")
  final String closingHour;

  @ColumnInfo(name: "latitude")
  final String? latitude;

  @ColumnInfo(name: "longitude")
  final String? longitude;

  @ColumnInfo(name: "imageUrl")
  final String? imageUrl;

  @ColumnInfo(name: "hotlineNumber")
  final String? hotlineNumber;

  @ColumnInfo(name: "googleMapUrl")
  final String? googleMapUrl;

  @ColumnInfo(name: "registrationDate")
  final String? registrationDate;

  @ColumnInfo(name: "lastUpdateDate")
  final String? lastUpdateDate;

  StoreEntity(
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
  );

  Store toStore() {
    return Store(
      storeId: storeId,
      imageUrl: imageUrl,
      address1: address1,
      address2: address2,
      address3: address3,
      address4: address4,
      closingHour: closingHour,
      googleMapUrl: googleMapUrl,
      hotlineNumber: hotlineNumber,
      lastUpdateDate: lastUpdateDate,
      latitude: latitude,
      longitude: longitude,
      openingHour: openingHour,
      registrationDate: registrationDate,
      storeName: storeName,
    );
  }
}
