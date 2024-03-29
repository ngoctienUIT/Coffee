import 'package:coffee/src/data/remote/response/tag/tag_response.dart';

class Tag {
  final String tagId;
  final String? tagName;
  final String? tagDescription;
  final String? tagColorCode;

  Tag({
    required this.tagId,
    this.tagName,
    this.tagDescription,
    this.tagColorCode,
  });

  factory Tag.fromTagResponse(TagResponse tagResponse) {
    return Tag(
      tagId: tagResponse.tagId,
      tagColorCode: tagResponse.tagColorCode,
      tagDescription: tagResponse.tagDescription,
      tagName: tagResponse.tagColorCode,
    );
  }
}
