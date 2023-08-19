import 'package:json_annotation/json_annotation.dart';

part 'upsize_response.g.dart';

@JsonSerializable()
class UpsizeResponse {
  @JsonKey(name: "S")
  final int? s;

  @JsonKey(name: "M")
  final int m;

  @JsonKey(name: "L")
  final int l;

  UpsizeResponse({this.s, required this.m, required this.l});

  factory UpsizeResponse.fromJson(Map<String, dynamic> json) =>
      _$UpsizeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpsizeResponseToJson(this);
}
