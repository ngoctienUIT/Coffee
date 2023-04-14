import '../../domain/repositories/tag/tag_response.dart';

class Tag {
  final String? tagId;
  final String? tagName;
  final String? tagDescription;
  final String? tagColorCode;
  bool isCheck;

  Tag({
    this.tagId,
    this.tagName,
    this.tagDescription,
    this.tagColorCode,
    this.isCheck = false,
  });

  factory Tag.fromTagResponse(TagResponse tagResponse) {
    return Tag(
      tagId: tagResponse.tagId,
      tagColorCode: tagResponse.tagColorCode,
      tagDescription: tagResponse.tagDescription,
      tagName: tagResponse.tagName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": tagName,
      "description": tagDescription,
      "color": tagColorCode,
    };
  }
}
