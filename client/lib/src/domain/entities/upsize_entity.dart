import 'package:json_annotation/json_annotation.dart';

part 'upsize_entity.g.dart';

@JsonSerializable()
class UpsizeEntity {
  @JsonKey(name: "S")
  final int s;

  @JsonKey(name: "M")
  final int m;

  @JsonKey(name: "L")
  final int l;

  UpsizeEntity({required this.s, required this.m, required this.l});

  factory UpsizeEntity.fromJson(Map<String, dynamic> json) =>
      _$UpsizeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpsizeEntityToJson(this);
}
