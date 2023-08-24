import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';

import 'package:coffee_admin/src/data/models/tag.dart';

import 'package:coffee_admin/src/data/remote/response/tag/tag_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/tag_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: TagRepository)
class TagRepositoryImpl extends TagRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  TagRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<TagResponse>> createTag(Tag tag) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response =
          await _apiService.createNewTag('Bearer $token', tag.toJson());
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TagResponse>> deleteTag(String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.removeTagByID('Bearer $token', id);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<TagResponse>>> getTag() async {
    try {
      final response = await _apiService.getAllTags();
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TagResponse>> updateTag(Tag tag) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.updateExistingTag(
          'Bearer $token', tag.toJson(), tag.tagId!);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
