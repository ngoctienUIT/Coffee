// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderResponse _$ProviderResponseFromJson(Map<String, dynamic> json) =>
    ProviderResponse(
      provider: json['SELF_PROVIDED'] as String?,
      google: json['GOOGLE'] as String?,
    );

Map<String, dynamic> _$ProviderResponseToJson(ProviderResponse instance) =>
    <String, dynamic>{
      'SELF_PROVIDED': instance.provider,
      'GOOGLE': instance.google,
    };
