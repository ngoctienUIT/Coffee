import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';

import 'package:coffee/src/data/remote/response/product/product_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/search_repository.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<DataState<List<ProductResponse>>> search(String query) async {
    try {
      final response = await _apiService.searchProductsByName(query);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
