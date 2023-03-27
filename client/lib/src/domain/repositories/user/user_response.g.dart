// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      isMale: json['isMale'] as bool,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      hashedPassword: json['hashedPassword'] as String,
      imageUrl: json['imageUrl'] as String?,
      userRole: json['userRole'] as String,
      accountProvider: json['accountProvider'] as String,
      accountProviderReferenceUid:
          json['accountProviderReferenceUid'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'userId': instance.id,
      'username': instance.username,
      'displayName': instance.displayName,
      'isMale': instance.isMale,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'hashedPassword': instance.hashedPassword,
      'imageUrl': instance.imageUrl,
      'userRole': instance.userRole,
      'accountProvider': instance.accountProvider,
      'accountProviderReferenceUid': instance.accountProviderReferenceUid,
    };
