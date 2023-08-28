import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/data/models/recommend.dart';
import 'package:coffee_admin/src/data/remote/response/recommend/recommend_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/recommend_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: RecommendRepository)
class RecommendRepositoryImpl extends RecommendRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  RecommendRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState> createRecommend(Recommend recommend) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      await _apiService.createNewRecommendation(
          'Bearer $token', recommend.toJson());
      return DataSuccess(null);
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
  Future<DataState> deleteRecommend(String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      await _apiService.deleteRecommendation("Bearer $token", id);
      return DataSuccess(null);
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
  Future<DataState<List<RecommendResponse>>> getRecommend() async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.getListRecommendation('Bearer $token');
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
  Future<DataState> updateRecommend(Recommend recommend) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      await _apiService.updateExistingRecommendation(
          'Bearer $token', recommend.id!, recommend.toJson());
      return DataSuccess(null);
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
