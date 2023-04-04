import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/core/utils/extensions/time_of_date_extension.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_response.g.dart';

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: "storeId")
  final String storeId;

  @JsonKey(name: "storeName")
  final String? storeName;

  @JsonKey(name: "address1")
  final String? address1;

  @JsonKey(name: "address2")
  final String? address2;

  @JsonKey(name: "address3")
  final String? address3;

  @JsonKey(name: "address4")
  final String? address4;

  @JsonKey(name: "openingHour")
  final String openingHour;

  @JsonKey(name: "closingHour")
  final String closingHour;

  @JsonKey(name: "latitude")
  final String? latitude;

  @JsonKey(name: "longitude")
  final String? longitude;

  @JsonKey(name: "imageUrl")
  final String? imageUrl;

  @JsonKey(name: "hotlineNumber")
  final String? hotlineNumber;

  @JsonKey(name: "googleMapUrl")
  final String? googleMapUrl;

  @JsonKey(name: "registrationDate")
  final String? registrationDate;

  @JsonKey(name: "lastUpdateDate")
  final String? lastUpdateDate;

  StoreResponse({
    required this.storeId,
    this.storeName,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    required this.openingHour,
    required this.closingHour,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.hotlineNumber,
    this.googleMapUrl,
    this.registrationDate,
    this.lastUpdateDate,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);

  bool checkOpen() =>
      openingHour.toTime().toInt() <= TimeOfDay.now().toInt() &&
      TimeOfDay.now().toInt() <= closingHour.toTime().toInt();
}
