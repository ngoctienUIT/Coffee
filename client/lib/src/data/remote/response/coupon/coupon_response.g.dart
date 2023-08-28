// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponResponse _$CouponResponseFromJson(Map<String, dynamic> json) =>
    CouponResponse(
      id: json['id'] as String,
      couponName: json['couponName'] as String,
      couponCode: json['couponCode'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      dueDate: json['dueDate'] as String,
    );

Map<String, dynamic> _$CouponResponseToJson(CouponResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'couponName': instance.couponName,
      'couponCode': instance.couponCode,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'dueDate': instance.dueDate,
    };
