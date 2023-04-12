import 'package:json_annotation/json_annotation.dart';

part 'provider_response.g.dart';

@JsonSerializable()
class ProviderResponse {
  @JsonKey(name: "SELF_PROVIDED")
  String? provider;

  @JsonKey(name: "GOOGLE")
  String? google;

  ProviderResponse({
    required this.provider,
    required this.google,
  });

  factory ProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderResponseToJson(this);
}
