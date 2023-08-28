import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/data/models/tag.dart';
import 'package:coffee_admin/src/data/remote/response/tag/tag_response.dart';

abstract class TagRepository {
  Future<DataState<List<TagResponse>>> getTag();

  Future<DataState<TagResponse>> createTag(Tag tag);

  Future<DataState<TagResponse>> updateTag(Tag tag);

  Future<DataState<TagResponse>> deleteTag(String id);
}
