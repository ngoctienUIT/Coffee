// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreResponse _$StoreResponseFromJson(Map<String, dynamic> json) =>
    StoreResponse(
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      address4: json['address4'] as String?,
      openingHour: json['openingHour'] as String,
      closingHour: json['closingHour'] as String,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      imageUrl: json['imageUrl'] as String?,
      hotlineNumber: json['hotlineNumber'] as String?,
      googleMapUrl: json['googleMapUrl'] as String?,
      registrationDate: json['registrationDate'] as String?,
      lastUpdateDate: json['lastUpdateDate'] as String?,
    );

Map<String, dynamic> _$StoreResponseToJson(StoreResponse instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'address4': instance.address4,
      'openingHour': instance.openingHour,
      'closingHour': instance.closingHour,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imageUrl': instance.imageUrl,
      'hotlineNumber': instance.hotlineNumber,
      'googleMapUrl': instance.googleMapUrl,
      'registrationDate': instance.registrationDate,
      'lastUpdateDate': instance.lastUpdateDate,
    };
