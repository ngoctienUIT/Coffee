import 'package:json_annotation/json_annotation.dart';

part 'tag_response.g.dart';

@JsonSerializable()
class TagResponse {
  @JsonKey(name: "tagId")
  final String tagId;

  @JsonKey(name: "tagName")
  final String? tagName;

  @JsonKey(name: "tagDescription")
  final String? tagDescription;

  @JsonKey(name: "tagColorCode")
  final String? tagColorCode;

  TagResponse({
    required this.tagId,
    this.tagName,
    this.tagDescription,
    this.tagColorCode,
  });

  factory TagResponse.fromJson(Map<String, dynamic> json) =>
      _$TagResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TagResponseToJson(this);
}
