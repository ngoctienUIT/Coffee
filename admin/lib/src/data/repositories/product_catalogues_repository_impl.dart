import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/data/remote/response/product_catalogues/product_catalogues_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/request/product_catalogues_request/product_catalogues_request.dart';
import '../../domain/repositories/product_catalogues_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: ProductCataloguesRepository)
class ProductCataloguesRepositoryImpl extends ProductCataloguesRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  ProductCataloguesRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<ProductCataloguesResponse>> createProductCatalogues(
      ProductCataloguesRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.productCatalogues.image = await uploadImage(
          folder: "product_catalogues",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.createNewProductCatalogue(
          'Bearer $token', request.productCatalogues.toJson());
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
  Future<DataState<ProductCataloguesResponse>> deleteProductCatalogues(
      String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response =
          await _apiService.removeProductCataloguesByID("Bearer $token", id);
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
  Future<DataState<List<ProductCataloguesResponse>>>
      getAllProductCatalogues() async {
    try {
      final response = await _apiService.getAllProductCatalogues();
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
  Future<DataState<ProductCataloguesResponse>> updateProductCatalogues(
      ProductCataloguesRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.productCatalogues.image = await uploadImage(
          folder: "product_catalogues",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.updateExistingProductCatalogue(
        'Bearer $token',
        request.productCatalogues.toJson(),
        request.productCatalogues.id!,
      );
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
