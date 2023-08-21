import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';
import 'package:coffee/src/data/remote/response/product/product_response.dart';
import 'package:coffee/src/data/remote/response/product_catalogues/product_catalogues_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/order_repository.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  OrderRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<DataState<List<ProductResponse>>> getListProduct(String id) async {
    try {
      final productResponse =
          await _apiService.getAllProductsFromProductCatalogueID(id);
      return DataSuccess(productResponse.data);
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

  @override
  Future<DataState<List<ProductCataloguesResponse>>>
      getProductCatalogues() async {
    try {
      final response = await _apiService.getAllProductCatalogues();
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
